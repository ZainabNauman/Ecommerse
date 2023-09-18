import '/models/item_model.dart';
import '/utils/color_constant.dart';
import '/utils/helper_function.dart';
import '/utils/responsive_class.dart';
import '/views/dashboard/home/addtoCart/addtocart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/provider/person_provider.dart';
import '/utils/string_constant.dart';
import '/widgets/custom_appbar.dart';
import 'categoryrow_widget.dart';
import 'item_gridview.dart';
import '/widgets/textfield_widget.dart';
import 'notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> { 
  final TextEditingController searchController = TextEditingController();
  int count=0;
  String searchQuery = ""; 
  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);
    Size size =responseMediaQuery(context);
    return Scaffold(
      appBar: CustomAppBar(title: StringConstant.titleString,
        actions: [
          if(!Responsive.isMobile(context)) Padding(padding:  EdgeInsets.all(size.width*0.002),
          child: Container(width: size.width*0.5,
            decoration: BoxDecoration(color: const Color.fromARGB(255, 226, 225, 225),borderRadius: BorderRadius.circular(15)),
            child: CustomTextField(
                controller: searchController,
                onSearchChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                }))),
          if(userDataProvider.profileData.brand.isEmpty) 
          IconButton(icon: const Icon(Icons.notifications_active),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) =>  const NotificationsPage())); 
              }),
          if(userDataProvider.profileData.brand.isEmpty) 
          IconButton(icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) =>  AddtoCart())); 
              })]),         
      body: Column(children: [
        Padding(padding:  EdgeInsets.symmetric(horizontal: size.width*0.02),child: 
          Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
            if(!Responsive.isMobile(context))SizedBox(height: size.width*0.02),
            if(Responsive.isMobile(context)) Expanded(child: 
            Padding(padding: EdgeInsets.symmetric(vertical:size.width*0.03),child: 
              Container(width: size.width*0.3,
                decoration: BoxDecoration(color: const Color.fromARGB(255, 226, 225, 225),borderRadius: BorderRadius.circular(15)),
                child: CustomTextField(
                controller: searchController,
                onSearchChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                })))),
        SizedBox(width: size.width*0.01)])),
        CategoryRow(onCategoryTapped: handleCategoryTapped,personBrand:userDataProvider.profileData.brand),
        Expanded(child: FutureBuilder<List<ItemModel>>(
          future: fetchItemsBySearch(searchQuery, userDataProvider.profileData.brand), //fetchAll(userDataProvider.profileData.brand), 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: SizedBox(height: size.width*0.1,width: size.width*0.1,child: const CircularProgressIndicator(color: ColorConstant.primaryColor,strokeWidth: 2))); 
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } 
            else {
              List<ItemModel>? specificCategoryItem = snapshot.data;
              if(count==1){
                String? categoryToFilter = "bed"; 
                specificCategoryItem = specificCategoryItem?.where((item) {
                  return item.category == categoryToFilter;
                }).toList();
              } else if(count==2){
                String? categoryToFilter = "chair"; 
                specificCategoryItem = specificCategoryItem?.where((item) {
                  return item.category == categoryToFilter;
                }).toList();
              } else if(count==3){
                String? categoryToFilter = "singlesofa"; 
                specificCategoryItem = specificCategoryItem?.where((item) {
                  return item.category == categoryToFilter;
                }).toList();
              } else if(count==4){
                String? categoryToFilter = "table"; 
                specificCategoryItem = specificCategoryItem?.where((item) {
                  return item.category == categoryToFilter;
                }).toList();
              } else if(count==5){
                String? categoryToFilter = "sofaset"; 
                specificCategoryItem = specificCategoryItem?.where((item) {
                  return item.category == categoryToFilter;
                }).toList();
              } else if(count==6){
                String? categoryToFilter = "studytable"; 
                specificCategoryItem = specificCategoryItem?.where((item) {
                  return item.category == categoryToFilter;
                }).toList();
              } else if(count==7){
                String? categoryToFilter = "bookshelf"; 
                specificCategoryItem = specificCategoryItem?.where((item) {
                  return item.category == categoryToFilter;
                }).toList();
              }
              return ItemGridView(specificCategoryItem!);
            }}))]));
  }         
  void handleCategoryTapped(int index) {
    setState(() {
      count=index;
    });
  }
}
