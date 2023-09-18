import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/person_model.dart';

class AdminPageProvider with ChangeNotifier {
  List<PersonModel> _usersWithoutAdminAndCustomer = [];
  List<PersonModel> _usersWithoutBrandAndAdmin = [];
  List<PersonModel> get usersWithoutAdminAndCustomer => _usersWithoutAdminAndCustomer;
  List<PersonModel> get usersWithoutBrandAndAdmin => _usersWithoutBrandAndAdmin;

  Future<void> fetchUsersWithoutAdminAndCustomer() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').where('admin', isEqualTo: '').get();
      final users = querySnapshot.docs.map((doc) => _createPersonModelFromSnapshot(doc)).where((user) => user.brand.isNotEmpty).toList();
      _usersWithoutAdminAndCustomer = users;
      notifyListeners();
    } catch (e) {
      print('Error fetching users without admin and brand: $e');
    }
  }

  Future<void> fetchUsersWithoutBrandAndAdmin() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').where('brand', isEqualTo: '').where('admin', isEqualTo: '').get();
      final users = querySnapshot.docs.map((doc) => _createPersonModelFromSnapshot(doc)).toList();
      _usersWithoutBrandAndAdmin = users;
      notifyListeners();
    } catch (e) {
      print('Error fetching users without brand and admin: $e');
    }
  }

  PersonModel _createPersonModelFromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PersonModel(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      phoneno: data['phone'] ?? '',
      address: data['address'] ?? '',
      birthday: data['birthday'] ?? '',
      brand: data['brand'] ?? '',
      bookmark: data['bookmark'] ?? [],
      uid: data['uid'] ?? '',
      admin: data['admin'] ?? '',
      img: data['img']
    );
  }
}
