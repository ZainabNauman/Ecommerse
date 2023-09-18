import 'package:cloud_firestore/cloud_firestore.dart';
import '/utils/helper_function.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/custom_button.dart';
import '/widgets/textfield_credentials.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/person_provider.dart';

// ignore: must_be_immutable
class CategoryAddScreen extends StatefulWidget {
  int index;
  BuildContext context;
  CategoryAddScreen({super.key, required this.context,  required this.index} );

  @override
  _CategoryAddScreenState createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<CategoryAddScreen> {
  final nameTfController = TextEditingController();
  final priceTfController = TextEditingController();
  final imgTfController = TextEditingController();
  final categoryTfController = TextEditingController();
  final quantityTfController = TextEditingController();
  var itemname = ['bed', 'chair', 'singlesofa', 'table','sofaset','studytable','bookshelf'];

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);
    String category= widget.index==1?itemname[0]:widget.index==2?itemname[1]:widget.index==3?itemname[2]:widget.index==4?itemname[3]:widget.index==5?itemname[4]:widget.index==6?itemname[5]:itemname[6];
    categoryTfController.text=category;
    Size size =responseMediaQuery(context);
    return Scaffold(
      appBar: CustomAppBar(title: widget.index==0 ?'Add Category':widget.index==1 ?'Add Bed':widget.index==2 ?'Add Chair':widget.index==3 ?'Add Single Sofa':widget.index==4 ?'Add Table':widget.index==5 ?'Add Sofa Set':widget.index==6 ?'Add Study Table':'Add Book Shelf'),
      body: Padding(
        padding: EdgeInsets.all(size.width*0.1),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,children: [
              CustomTextFieldCredential(controller: nameTfController,hint: "Enter Name", icon: const Icon(Icons.bed_sharp), isObscure: false, text: "Name"),
              SizedBox(height: size.width*0.1),
              CustomTextFieldCredential(controller: priceTfController,hint: "Enter Price", icon: const Icon(Icons.money), isObscure: false, text: "Price"),
              SizedBox(height: size.width*0.1),
              CustomTextFieldCredential(controller: imgTfController,hint: "Enter Image", icon: const Icon(Icons.image), isObscure: false, text: "Image"),
              SizedBox(height: size.width*0.15),
              CustomTextFieldCredential(controller: quantityTfController,hint: "Enter Quantity", icon: const Icon(Icons.production_quantity_limits_sharp), isObscure: false, text: "Quantity"),
              SizedBox(height: size.width*0.15),
              CustomButton(text: 'Save', 
              onTap: () {
                if (nameTfController.text.trim().isNotEmpty && priceTfController.text.trim().isNotEmpty && imgTfController.text.trim().isNotEmpty && userDataProvider.profileData.brand.trim().isNotEmpty&& category.trim().isNotEmpty&& quantityTfController.text.trim().isNotEmpty) {
                  addElementToFirestore(nameTfController.text, priceTfController.text, imgTfController.text, userDataProvider.profileData.brand,category,int.parse(quantityTfController.text));
                  Navigator.of(context).pop();
                }})]))));
  }
  Future<String?> addElementToFirestore(String name, String price, String img, String brand, String category,int quantity) async {
    try {
      final DocumentReference docRef = FirebaseFirestore.instance.collection('items').doc();
      final String documentId = docRef.id;
      await docRef.set({'name': name});
      await FirebaseFirestore.instance.collection('items').doc(docRef.id).set({
        'name': name,
        'price': price,
        'img': img,
        'brand': brand,
        'category': category,
        'id': documentId,
        'quantity':quantity
      });
      return documentId;
    } catch (e) {
      return null;
    }
  }
}