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
      duration: const Duration(seconds: 2), // Adjust the duration as needed
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

//////////////////CategoriesList////////////////////////////////////////

// void uploadCategoriesToFirestore() async {
//   CollectionReference categoriesCollection = FirebaseFirestore.instance.collection('categories');
//   for (var category in ImageConstant.categories) {
//     await categoriesCollection.add({
//       'title': category.title,
//       'imageUrl': category.imageUrl,
//     });
//   }
//   print('Categories uploaded to Firestore');
// }

Stream<List<CategoryModel>> getCategoryData() {
  return FirebaseFirestore.instance
      .collection('categories')
      .snapshots()
      .map((QuerySnapshot snapshot) {
    List<CategoryModel> categories = [];
    snapshot.docs.forEach((DocumentSnapshot doc) {
      final category = CategoryModel(
        title: doc['title'], // Use 'doc' to access data in the document
        imageUrl: doc['imageUrl'],
      );
      categories.add(category); // Add the category to the list
    });
    return categories;
  });
}

//////////////////////All Items///////////////////////////////////////////

// void uploadItemToFirestore() async {
//   CollectionReference categoriesCollection = FirebaseFirestore.instance.collection('table');
//   for (var item in ImageConstant.tableList) {
//     await categoriesCollection.add({
//       'name': item.name,
//       'price': item.price,
//       'img': item.img,
//     });
//   }
//   print('Categories uploaded to Firestore');
// }

//////////All////////////////
Future<List<ItemModel>> fetchAll( String? brand) async {
  try {
    String collectionName = 'items';
    
    final skillsCollection =
        FirebaseFirestore.instance.collection(collectionName);
    final skillsSnapshot = await skillsCollection.get();
    final skills = skillsSnapshot.docs
        .where((doc) {
          final data = doc.data();
          if (brand == null || brand.isEmpty) {
            return true;
          } else {
            final itemBrand = data['brand'] as String;
            return itemBrand == brand;
          }
        })
        .map((doc) {
          final data = doc.data();
          return ItemModel(
            name: data['name'],
            price: data['price'],
            img: data['img'],
            brand: data['brand'],
            category: data['category'],
            id:data['id'],
            quantity: data['quantity']
          );
        })
        .toList();
    return skills;
  } catch (error) {
    print('Error fetching skills data: $error');
    return [];
  }
}


