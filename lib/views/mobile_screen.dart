import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../utils/color_constant.dart';
import '../utils/image_constant.dart';
import '../utils/string_constant.dart';
import '../widgets/bottombar_widget.dart';
import '../widgets/categoryrow_widget.dart';
import '../widgets/item_gridview.dart';
import '../widgets/textfield_widget.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
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
              Icons.add_shopping_cart_rounded,color: ColorConstant.black,size: screenWidth*0.06),
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
                    controller: searchController,
                    ))),
              SizedBox(width: screenWidth*0.01),        
              Container(
                height: screenWidth*0.09,
                width: screenWidth*0.09,
                decoration:  BoxDecoration(color: ColorConstant.black,borderRadius: BorderRadius.circular(8)),
                child: Image.asset(ImageConstant.searchImage,color: Colors.white,),
              )])),
              CategoryRow(ImageConstant.categories),
              Expanded(child: ItemGrid(projects)),
              ]),
              bottomNavigationBar: BottomNavigationBarExample(),
              ));
  }
            
  
}
