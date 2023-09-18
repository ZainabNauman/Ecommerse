import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse/provider/person_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailProvider with ChangeNotifier{

    Future<DocumentSnapshot?> fetchItemData(String orderId) async {
    try {
      final itemDoc = await FirebaseFirestore.instance.collection('orders').doc(orderId).get();
      return itemDoc;
    } catch (e) {
      print('Error fetching item data: $e');
      return null;
    }
  }
  Future<String?> fetchProductName(String productId) async {
    try {
      final itemDoc = await FirebaseFirestore.instance.collection('items').doc(productId).get();
      return itemDoc['name'];
    } catch (e) {
      print('Error fetching product name: $e');
      return null;
    }
  }

  Future<double> fetchProductPrice(String productId) async {
    try {
      final itemDoc = await FirebaseFirestore.instance.collection('items').doc(productId).get();
      return double.parse(itemDoc['price']) ;
    } catch (e) {
      print('Error fetching product price: $e');
      return 0.0;
    }
  }
  ///////Vendor
  Future<DocumentSnapshot?> fetchItemDataV(BuildContext context,String orderId ,String? customerband) async {
    final userDataProvider = Provider.of<UserDataProvider>(context,listen: false);
    final brand = userDataProvider.profileData.admin.isNotEmpty ? customerband : userDataProvider.profileData.brand;
    try {
      final itemDoc = await FirebaseFirestore.instance.collection('ordersforvendors').doc(brand).collection('vendororders').doc(orderId).get();
      if (itemDoc.exists) {
        print('Item document exists for orderId: $orderId');
        return itemDoc;
      } else {
        print('Item document does not exist for orderId: $orderId');
        return null;
      }
    } catch (e) {
      print('Error fetching item data: $e');
      return null;
    }
  }

  Future<String?> fetchProductNameV(String productId) async {
    try {
      final itemDoc = await FirebaseFirestore.instance.collection('items').doc(productId).get();
      return itemDoc['name'];
    } catch (e) {
      print('Error fetching product name: $e');
      return null;
    }
  }

  Future<double> fetchProductPriceV(String productId) async {
    try {
      final itemDoc = await FirebaseFirestore.instance.collection('items').doc(productId).get();
      return double.parse(itemDoc['price']) ;
    } catch (e) {
      print('Error fetching product price: $e');
      return 0.0;
    }
  }
}