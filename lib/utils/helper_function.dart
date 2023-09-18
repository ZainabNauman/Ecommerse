import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse/models/item_model.dart';
import 'package:ecommerse/utils/responsive_class.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';

 responseSize (double value,BuildContext context){
   return Responsive.isMobile(context) ?value
   :Responsive.isTablet(context) ?value/2
   :value/3;
  }
  responseSizeforImageRow (double value,BuildContext context){
   return Responsive.isMobile(context) ?value
   :Responsive.isTablet(context) ?value/1.5
   :value/2;
  }

  responseMediaQuery (BuildContext context){
   return Responsive.isMobile(context) ?MediaQuery.of(context).size
   :Responsive.isTablet(context) ?MediaQuery.of(context).size/2
   :MediaQuery.of(context).size/3;
  }
 
  showSnackbar(BuildContext context, String text) {
    var snackBar = SnackBar(
      backgroundColor: Colors.black,
      content: Text(text),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
//////////////////CategoriesList////////////////////////////////////////
  Stream<List<CategoryModel>> getCategoryData() {
    return FirebaseFirestore.instance.collection('categories').snapshots().map((QuerySnapshot snapshot) {
      List<CategoryModel> categories = [];
      snapshot.docs.forEach((DocumentSnapshot doc) {
        final category = CategoryModel(title: doc['title'], imageUrl: doc['imageUrl'],);
        categories.add(category); 
      });
      return categories;
    });
  }
//////////////////////All Items///////////////////////////////////////////
// Future<List<ItemModel>> fetchAll( String? brand) async {
//   try {
//     String collectionName = 'items';
//     final skillsCollection =FirebaseFirestore.instance.collection(collectionName);
//     final skillsSnapshot = await skillsCollection.get();
//     final skills = skillsSnapshot.docs.where((doc) {
//       final data = doc.data();
//       if (brand == null || brand.isEmpty) {
//         return true;
//       } else {
//         final itemBrand = data['brand'] as String;
//         return itemBrand == brand;
//       }
//     }).map((doc) {
//           final data = doc.data();
//           return ItemModel(
//           name: data['name'],
//           price: data['price'],
//           img: data['img'],
//           brand: data['brand'],
//           category: data['category'],
//           id:data['id'],
//           quantity: data['quantity']);
//       }).toList();
//     return skills;
//   } catch (error) {
//     print('Error fetching skills data: $error');
//     return [];
//   }
// }
  Future<List<ItemModel>> fetchItemsBySearch(String query, String? brand) async {
    try {
      String collectionName = 'items';
      final skillsCollection = FirebaseFirestore.instance.collection(collectionName);
      final skillsSnapshot = await skillsCollection.get();
      final skills = skillsSnapshot.docs.where((doc) {
        final data = doc.data();
          final itemName = data['name'] as String;
          final itemBrand = data['brand'] as String;
          return (brand == null || brand.isEmpty || itemBrand == brand) &&
            itemName.toLowerCase().contains(query.toLowerCase());   
      }).map((doc) {
        final data = doc.data();
        return ItemModel(
          name: data['name'],
          price: data['price'],
          img: data['img'],
          brand: data['brand'],
          category: data['category'],
          id: data['id'],
          quantity: data['quantity'],
        );
      }).toList();
      return skills;
    } catch (error) {
      print('Error fetching skills data: $error');
      return [];
    }
  }