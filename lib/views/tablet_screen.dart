import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../utils/color_constant.dart';
import '../utils/image_constant.dart';
import '../utils/string_constant.dart';
import '../widgets/bottombar_widget.dart';
import '../widgets/categoryrow_widget.dart';
import '../widgets/item_gridview.dart';
import '../widgets/textfield_widget.dart';

class TabletLayout extends StatefulWidget {
  const TabletLayout({super.key});

  @override
  State<TabletLayout> createState() => _TabletLayout();
}

class _TabletLayout extends State<TabletLayout> {
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
                height: screenWidth>=650 && screenWidth < 730 ?screenWidth*0.08
                :screenWidth>=730 && screenWidth < 810 ?screenWidth*0.07
                :screenWidth>=810 && screenWidth < 890 ?screenWidth*0.06
                :screenWidth>=890 && screenWidth < 950 ?screenWidth*0.05
                :screenWidth>=950 && screenWidth < 1030 ?screenWidth*0.048
                :screenWidth>=1030 && screenWidth < 1100 ?screenWidth*0.043
                :screenWidth*0.02,
                width: screenWidth>=650 && screenWidth < 730 ?screenWidth*0.08
                :screenWidth>=730 && screenWidth < 810 ?screenWidth*0.07
                :screenWidth>=810 && screenWidth < 890 ?screenWidth*0.06
                :screenWidth>=890 && screenWidth < 950 ?screenWidth*0.05
                :screenWidth>=950 && screenWidth < 1030 ?screenWidth*0.048
                :screenWidth>=1030 && screenWidth < 1100 ?screenWidth*0.043 
                :screenWidth*0.02,
                decoration:  BoxDecoration(color: ColorConstant.black,borderRadius: BorderRadius.circular(8)),
                child: Image.asset(ImageConstant.searchImage,color: Colors.white,),
              )])),
              CategoryRow(ImageConstant.categories),
              Expanded(child: ItemGrid(projects))
              
              ]),
              bottomNavigationBar: BottomNavigationBarExample(),
              ));
  }
   
}
