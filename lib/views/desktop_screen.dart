import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../utils/color_constant.dart';
import '../utils/image_constant.dart';
import '../utils/string_constant.dart';
import '../widgets/bottombar_widget.dart';
import '../widgets/categoryrow_widget.dart';
import '../widgets/item_gridview.dart';
import '../widgets/textfield_widget.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayout();
}

class _DesktopLayout extends State<DesktopLayout> {
  final TextEditingController searchController = TextEditingController();
  @override
   Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title:  Text(StringConstant.titleString,style: TextStyle(color: ColorConstant.black,fontWeight: FontWeight.bold,fontSize: screenWidth*0.05,fontFamily: StringConstant.font),),
          actions:  [
            Padding(padding:  EdgeInsets.only(right:screenWidth*0.04),
            child: Icon(
              Icons.shopping_cart,color: ColorConstant.black,size: screenWidth*0.06),
          )]),
        body: Column(
         children: [
          Padding(padding:  EdgeInsets.all(screenWidth*0.04),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 226, 225, 225),borderRadius: BorderRadius.circular(15)),
                  width: screenWidth*0.4,
                  child: CustomTextField(
                    controller: searchController))),
              SizedBox(width: screenWidth*0.01),        
              Container(
                height: 
                screenWidth>=1100 && screenWidth<1190
                ?screenWidth*0.05
                :screenWidth>=1190 && screenWidth<1270
                ?screenWidth*0.04
                :screenWidth>=1270 && screenWidth<1350
                ?screenWidth*0.035
                :screenWidth>=1350 && screenWidth<1430
                ?screenWidth*0.034
                :screenWidth>=1430 && screenWidth<1500
                ?screenWidth*0.033
                :screenWidth>=1500 && screenWidth<1600
                ?screenWidth*0.032
                :screenWidth*0.031,
                width: 
                screenWidth>=1100 && screenWidth<1190
                ?screenWidth*0.05
                :screenWidth>=1190 && screenWidth<1270
                ?screenWidth*0.04
                :screenWidth>=1270 && screenWidth<1350
                ?screenWidth*0.035
                :screenWidth>=1350 && screenWidth<1430
                ?screenWidth*0.034
                :screenWidth>=1430 && screenWidth<1500
                ?screenWidth*0.033
                :screenWidth>=1500 && screenWidth<1600
                ?screenWidth*0.032             
                :screenWidth*0.031,
                decoration:  BoxDecoration(color: ColorConstant.black,borderRadius: BorderRadius.circular(8)),
                child: Image.asset(ImageConstant.searchImage,color: Colors.white,),
              )])),
              CategoryRow(ImageConstant.categories),
              Expanded(child: ItemGrid(projects))
              ]),
              bottomNavigationBar: const BottomNavigationBarExample(),
              ));
  }
  
}
