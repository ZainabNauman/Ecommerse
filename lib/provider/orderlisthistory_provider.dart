import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class OrderListHistoryProvider with ChangeNotifier{

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

  Future<List<DocumentSnapshot>> fetchOrdersForCustomerUser(String? customeruid) async {  
    final userId = customeruid;
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
  /////////vendor
  Future<DocumentSnapshot?> fetchItemDataV(String productId) async {
    try {
      final itemDoc = await FirebaseFirestore.instance.collection('items').doc(productId).get();
      return itemDoc;
    } catch (e) {
      print('Error fetching item data: $e');
      return null;
    }
  } 
}