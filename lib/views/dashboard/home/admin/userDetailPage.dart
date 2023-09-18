import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse/utils/color_constant.dart';
import 'package:ecommerse/utils/helper_function.dart';
import 'package:ecommerse/utils/string_constant.dart';
import 'package:ecommerse/views/dashboard/orderhistory/orderlistvendor_history.dart';
import 'package:ecommerse/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import '../../../../models/person_model.dart';
import '../../orderhistory/orderlist_history_page.dart';

class UserDetailScreen extends StatefulWidget {
  final PersonModel user;
  UserDetailScreen({required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  double totalMoney=0.0;
  @override
  Widget build(BuildContext context) {
    Size size=responseMediaQuery(context);
    return Scaffold(
      appBar: CustomAppBar(title: "${widget.user.name}'s Detail"),
      body: Padding(padding:  EdgeInsets.all(size.width*0.06),
        child: FutureBuilder<double>(
          future: displayOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: ColorConstant.primaryColor,strokeWidth: 2));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final totalMoney = snapshot.data ?? 0.0;
              return SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Card(elevation: 10,
                    child: Padding(padding: EdgeInsets.all(size.width*0.05),
                      child: Row(children: [
                        const Icon(Icons.person),
                        SizedBox(width: size.width*0.03),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                          Text('Name:',style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.normal,fontSize: size.width*0.04)),
                          SizedBox(height: size.width*0.01),
                          Text(widget.user.name,style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.bold,fontSize: size.width*0.04))])]))),
                  SizedBox(height: size.width*0.05),
                  Card(elevation: 10,
                    child: Padding(padding: EdgeInsets.all(size.width*0.05),
                    child: Row(children: [
                        const Icon(Icons.email),
                        SizedBox(width: size.width*0.03),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                            Text('Email:',style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.normal,fontSize: size.width*0.04)),
                            SizedBox(height: size.width*0.01,),
                            Text(widget.user.email,style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.bold,fontSize: size.width*0.04))])]))),
                  SizedBox(height: size.width*0.05),
                  Card(elevation: 10,
                    child: Padding(padding: EdgeInsets.all(size.width*0.05),
                    child: Row(children: [
                        const Icon(Icons.phone_android_sharp),
                        SizedBox(width: size.width*0.03),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                          Text('PhoneNo:',style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.normal,fontSize: size.width*0.04)),
                          SizedBox(height: size.width*0.01,),
                          Text(widget.user.phoneno,style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.bold,fontSize: size.width*0.04))])]))),
                  SizedBox(height: size.width*0.05),
                  Card(elevation: 10,
                    child: Padding(padding: EdgeInsets.all(size.width*0.05),
                      child: Row(children: [
                        const Icon(Icons.branding_watermark_outlined),
                        SizedBox(width: size.width*0.03),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                          Text(widget.user.brand.isEmpty ? 'UserType:' : 'Brand:',style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.normal,fontSize: size.width*0.04)),
                          SizedBox(height: size.width*0.01,),
                          Text(widget.user.brand.isEmpty ? 'Customer' :widget.user.brand,style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.bold,fontSize: size.width*0.04))])]))),
                  SizedBox(height: size.width*0.05),
                  Card(elevation: 10,
                    child: Padding(padding: EdgeInsets.all(size.width*0.05),
                      child: Row(children: [
                        const Icon(Icons.cake_sharp),
                        SizedBox(width: size.width*0.03),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                          Text('Birthday:',style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.normal,fontSize: size.width*0.04)),
                          SizedBox(height: size.width*0.01,),
                          Text(widget.user.birthday,style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.bold,fontSize: size.width*0.04))])]))),
                  SizedBox(height: size.width*0.05),
                  Card(elevation: 10,
                    child: Padding(padding: EdgeInsets.all(size.width*0.05),
                    child: Row(children: [
                        const Icon(Icons.location_on_outlined),
                        SizedBox(width: size.width*0.03),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                          Text('Address:',style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.normal,fontSize: size.width*0.04)),
                          SizedBox(height: size.width*0.01,),
                          Text(widget.user.address,style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.bold,fontSize: size.width*0.04))])]))),
                  SizedBox(height: size.width*0.05),
                  if(widget.user.brand.isEmpty)
                  InkWell(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) =>  HistoryPage(customeruid:widget.user.uid)));
                    },
                    child: Card(elevation: 10,
                      child: Padding(padding: EdgeInsets.all(size.width*0.05),
                        child: Row(children: [
                          const Icon(Icons.donut_large_sharp),
                          SizedBox(width: size.width*0.03),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                            Text('Orders',style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.normal,fontSize: size.width*0.04))]),
                            Expanded(child: SizedBox(width: size.width*0.1)),
                            const Icon(Icons.forward_rounded),
                        ])))),
                      if(widget.user.brand.isNotEmpty)
                      InkWell(
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>  HistoryPageVendor(customerbrand:widget.user.brand)));
                        },
                        child: Card(elevation: 10,
                          child: Padding(padding: EdgeInsets.all(size.width*0.05),
                            child: Row(children: [
                              const Icon(Icons.donut_large_sharp),
                              SizedBox(width: size.width*0.03),
                              Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                Text('Orders',style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.normal,fontSize: size.width*0.04)),
                                Text('\$${totalMoney.toStringAsFixed(2)}',style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.bold,fontSize: size.width*0.04))]),
                                Expanded(child: SizedBox(width: size.width*0.1)),
                                const Icon(Icons.forward_rounded)
                            ]))))]),
              );
    }})));
  }

  Future<double> displayOrders() async { 
  final brand = widget.user.brand;
      double money=0;
  try {
    final querySnapshot = await FirebaseFirestore.instance.collection('ordersforvendors').doc(brand).collection('vendororders').get();
    for (final orderDoc in querySnapshot.docs) {
      final orderItems = orderDoc['orderItems'];
      double totalAmount = 0;
      for (final item in orderItems) {
        final productId = item['productId'];
        final productQuantity = item['productQuantity'];
        final itemData = await fetchItemData(productId);
        if (itemData != null) {
          final itemPrice = itemData['price'];
          if (itemPrice != null) {
            totalAmount = totalAmount + double.parse(itemPrice) * productQuantity;
            money += totalAmount;
          } else {
            print('Price not found for Product ID: $productId');
          }
        } else {
          print('Item data not found for Product ID: $productId');
        }
      }   
    }
    return money; 
  } catch (e) {
    print('Error fetching orders: $e');
    return 0.0;
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
}