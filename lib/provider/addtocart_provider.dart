import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/item_model.dart';
import '../utils/helper_function.dart';
import 'person_provider.dart';

class AddtoCartProvider with ChangeNotifier {
  List<ItemModel> _cartItems = [];
  List<ItemModel> get cartItems => _cartItems;
  List<ItemModel> _originalItems = [];
  List<ItemModel> get originalItems => _originalItems;
  Map<String, int> itemQuantities = {};

  Future<void> toggleAddtoCart(BuildContext context, ItemModel item, int quantity) async {
    final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    final userId = userDataProvider.profileData.uid;
    final cartDocRef = FirebaseFirestore.instance.collection('carts').doc(userId);
    try {
      final cartDoc = await cartDocRef.get();
      if (!cartDoc.exists) {
        await cartDocRef.set({'userId': userId, 'cartItems': []});
      }
      final List<Map<String, dynamic>> cartItemsList = List<Map<String, dynamic>>.from(cartDoc.data()?['cartItems'] ?? []);
      bool productExists = false;
      for (int i = 0; i < cartItemsList.length; i++) {
        if (cartItemsList[i]['productId'] == item.id) {
          cartItemsList[i]['quantity'] += quantity;
          productExists = true;
          break;
        }
      }
      if (!productExists) {
        cartItemsList.add({
          'productId': item.id,
          'quantity': quantity,
        });
      }
      await cartDocRef.update({'cartItems': cartItemsList});
      notifyListeners();
      showSnackbar(context, "Added to Cart");
    } catch (e) {
      print('Error adding product to cart: $e');
    }
  }

  Future<void> removeItemFromCart(BuildContext context, ItemModel item) async {
    final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    final userId = userDataProvider.profileData.uid;
    try {
      final cartDocRef = FirebaseFirestore.instance.collection('carts').doc(userId);
      final cartDoc = await cartDocRef.get();
      if (cartDoc.exists) {
        final List<Map<String, dynamic>> cartItemsList = List<Map<String, dynamic>>.from(cartDoc.data()?['cartItems'] ?? []);
        cartItemsList.removeWhere((cartItem) => cartItem['productId'] == item.id);
        await cartDocRef.update({'cartItems': cartItemsList});
      }
      _cartItems.remove(item);
      notifyListeners();
      showSnackbar(context, "Removed from Cart");
    } catch (e) {
      print('Error removing product from cart: $e');
    }
  }

  Future<void> fetchCartItems(BuildContext context) async {
    try {
      final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
      final userId = userDataProvider.profileData.uid;
      final cartDocRef = FirebaseFirestore.instance.collection('carts').doc(userId);
      final cartDoc = await cartDocRef.get();
      if (cartDoc.exists) {
        final List<Map<String, dynamic>> cartItemsList = List<Map<String, dynamic>>.from(cartDoc.data()?['cartItems'] ?? []);
        final List<ItemModel> cartItems = [];
        for (final cartItem in cartItemsList) {
          final productId = cartItem['productId'];
          final quantity = cartItem['quantity'];
          final itemDocSnapshot = await FirebaseFirestore.instance.collection('items').doc(productId).get();
          if (itemDocSnapshot.exists) {
            final data = itemDocSnapshot.data() as Map<String, dynamic>;
            final item = ItemModel(
              id: productId,
              name: data['name'],
              price: data['price'],
              img: data['img'],
              brand: data['brand'],
              category: data['category'],
              quantity: quantity);
            cartItems.add(item);
          }
        }
        _cartItems = cartItems;
        await fetchTotalQuantities(_cartItems,context);
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching cart items: $e');
    }
  }

  Future<void> placeOrder(BuildContext context, AddtoCartProvider cartProvider, String userId) async {
  try {
    final cartItems = cartProvider.cartItems;
    final brandItemsMap = <String, List<ItemModel>>{};
    bool canPlaceOrder = true;
    for (final item in cartItems) {
      if (!brandItemsMap.containsKey(item.brand)) {
        brandItemsMap[item.brand] = [];
      }
      brandItemsMap[item.brand]!.add(item);
      final itemDoc = await FirebaseFirestore.instance.collection('items').doc(item.id).get();
      final availableQuantity = itemDoc.data()?['quantity'] ?? 0;
      if (item.quantity > availableQuantity) {
        canPlaceOrder = false;
        break;
      }
    }

    if (canPlaceOrder) {
      final orderDocRef = FirebaseFirestore.instance.collection('orders').doc();
      final orderData = {
        'userId': userId,
        'orderItems': cartItems.map((item) => {
          'productId': item.id,
          'productQuantity': item.quantity,
        }).toList(),
        'status': 'placed',
        'id': orderDocRef.id,
      };
      await orderDocRef.set(orderData);
      for (final brand in brandItemsMap.keys) {
        final brandOwnerDocRef = FirebaseFirestore.instance.collection('ordersforvendors').doc(brand);
        final vendorOrderDocRef = brandOwnerDocRef.collection('vendororders').doc();
        final vendorOrderData = {
          'brand': brandOwnerDocRef.id,
          'userId': userId,
          'orderItems': brandItemsMap[brand]!.map((item) => {
            'productId': item.id,
            'productQuantity': item.quantity,
          }).toList(),
          'status': 'placed',
          'id': orderDocRef.id,
        };
        await vendorOrderDocRef.set(vendorOrderData);
      }

      for (final item in cartItems) {
        final itemDoc = FirebaseFirestore.instance.collection('items').doc(item.id);
        await itemDoc.update({'quantity': FieldValue.increment(-item.quantity)});
      }
      cartProvider.clearCartFirebase(userId);
      cartProvider.clearCart();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your order has been placed!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order cannot be placed. Item quantity exceeds availability.')));
    }
  } catch (e) {
    print('Error placing order: $e');
  }
}

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  Future<void> clearCartFirebase(String userId) async {
    try {
      final cartDocRef = FirebaseFirestore.instance.collection('carts').doc(userId);
      await cartDocRef.delete();
    } catch (e) {
      print('Error clearing cart: $e');
    }
  }

void updateItemQuantity(BuildContext context,ItemModel item, int newQuantity) {
  final cartItem = _cartItems.firstWhere((cartItem) => cartItem.id == item.id);
  if (cartItem != null) {
    cartItem.quantity = newQuantity;  
    notifyListeners();
    _updateCartInFirebase(context);
  }
}

Future<void> _updateCartInFirebase(BuildContext context) async {
  final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
  final userId = userDataProvider.profileData.uid;

  try {
    final cartDocRef = FirebaseFirestore.instance.collection('carts').doc(userId);  
    final cartItemsList = _cartItems.map((item) {
      return {
        'productId': item.id,
        'quantity': item.quantity,
      };
    }).toList();

    await cartDocRef.update({'cartItems': cartItemsList});
  } catch (e) {
    print('Error updating cart in Firebase: $e');
  }
}

Future<void> fetchTotalQuantities(List<ItemModel> cartItems,BuildContext context) async {
  //final cartProvider = Provider.of<AddtoCartProvider>(context, listen: false);

  for (int i = 0; i < cartItems.length; i++) {
    final item = cartItems[i];
    final availableQuantity = await totalQuantity(item.id);

    if (availableQuantity < item.quantity) {
      try {
        updateItemQuantity(context, item, availableQuantity);
      } catch (e) {
        print("Error updating item quantity: $e");
      }
    }

    itemQuantities[item.id] = availableQuantity;
  }
}

  Future<int> totalQuantity(String id) async {
    final itemDoc = await FirebaseFirestore.instance.collection('items').doc(id).get();
    inspect(itemDoc);
    final availableQuantity = itemDoc.data()?['quantity'] ?? 0;
    return availableQuantity;
  }

}
