import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse/utils/color_constant.dart';
import 'package:ecommerse/utils/helper_function.dart';
import 'package:ecommerse/utils/string_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/person_provider.dart';
import '../../../widgets/custom_appbar.dart';
import 'orderdetail_page.dart';

class HistoryPage extends StatefulWidget {
  final String? customeruid;
  const HistoryPage({super.key, this.customeruid});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  List<Map<String, dynamic>> orderDetails = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    displayOrders();
  }

  @override
  Widget build(BuildContext context) {
    Size size = responseMediaQuery(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'Order Details'),
      body: Padding(padding: EdgeInsets.only(top: size.width * 0.03, bottom: size.width * 0.03),
        child: isLoading
            ? const Center(child: CircularProgressIndicator(color: ColorConstant.primaryColor,strokeWidth: 2))
            :ListView.separated(
          itemCount: orderDetails.length,
          separatorBuilder: (context, index) => SizedBox(height: size.width * 0.04),
          itemBuilder: (context, index) {
            final orderDetail = orderDetails[index];
            final orderId = orderDetail['orderId'];
            final totalAmount = orderDetail['totalAmount'];
            return InkWell(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) =>  OrderDetailPage(orderId:orderId)));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(size.width * 0.04),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: ColorConstant.primaryColor,borderRadius: BorderRadius.circular(20)),
                           child: Padding(padding: EdgeInsets.all(size.width * 0.02),
                            child: Text((index + 1).toString(),style: const TextStyle(color: Colors.white)))),
                        SizedBox(width: size.width * 0.05),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order #$orderId', style: TextStyle(fontFamily: StringConstant.font)),
                            Text('Total: \$${totalAmount.toStringAsFixed(2)}',style: TextStyle(fontFamily: StringConstant.font))])])))));
          })));
  }

  Future<void> displayOrders() async {
    final userDataProvider = Provider.of<UserDataProvider>(context,listen: false);
    final orders = userDataProvider.profileData.admin.isEmpty? await fetchOrdersForCurrentUser():await fetchOrdersForCustomerUser();
    for (final order in orders) {
      final orderId = order.id;  
      final orderItems = order['orderItems'];
      double totalAmount = 0;
      for (final item in orderItems) {
        final productId = item['productId'];
        final productQuantity = item['productQuantity'];
        final itemData = await fetchItemData(productId);
        if (itemData != null) {
          final itemPrice = itemData['price'];
          totalAmount = totalAmount + double.parse(itemPrice) * productQuantity;
        } else {
          print('Item data not found for Product ID: $productId');
        }
      }

      orderDetails.add({
        'orderId': orderId,
        'totalAmount': totalAmount,
      });
      isLoading = false;
      print('---'); 
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<DocumentSnapshot?> fetchItemData(String productId) async {
    try {
      final itemDoc = await FirebaseFirestore.instance.collection('items').doc(productId).get();
      return itemDoc;
    } catch (e) {
      print('Error fetching item data: $e');
      return null;
    }
  }


  Future<List<DocumentSnapshot>> fetchOrdersForCurrentUser() async {
    
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser?.uid;
    if (userId == null) {
      return [];
    }
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('orders').where('userId', isEqualTo: userId).get();
      return querySnapshot.docs;
    } catch (e) {
      print('Error fetching orders: $e');
      return [];
    }
  }
  Future<List<DocumentSnapshot>> fetchOrdersForCustomerUser() async {
    
    final userId = widget.customeruid;
    if (userId == null) {
      return [];
    }
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('orders').where('userId', isEqualTo: userId).get();
      return querySnapshot.docs;
    } catch (e) {
      print('Error fetching orders: $e');
      return [];
    }
  }
  
}