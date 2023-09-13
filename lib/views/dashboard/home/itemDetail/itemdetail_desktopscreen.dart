import 'package:ecommerse/models/item_model.dart';
import 'package:ecommerse/utils/helper_function.dart';
import 'package:ecommerse/utils/string_constant.dart';
import 'package:ecommerse/views/dashboard/home/itemDetail/itemcounter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/addtocart_provider.dart';
import '../../../../provider/bookmark_provider.dart';
import '../../../../provider/person_provider.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_chachenetwork_image.dart';
import '../../../../widgets/ratingbar.dart';

// ignore: must_be_immutable
class IndividualItemDesktop extends StatefulWidget{ 
  ItemModel item;

  IndividualItemDesktop({super.key,required this.item});

  @override
  State<IndividualItemDesktop> createState() => _IndividualItemDesktopState();
}

class _IndividualItemDesktopState extends State<IndividualItemDesktop> {
  bool isBookmarked = false;
  int numberOfItems =0;

  @override
  Widget build(BuildContext context) {
    Size size = responseMediaQuery(context);
    return Scaffold(appBar:  CustomAppBar(title: 'Order Details'),
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: Center(
              child: CustomCachedNetworkImage(
                imageUrl: widget.item.img,
                ))),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Center(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.width*0.08,left:size.width*0.04,bottom: size.width*0.01),
                      child: Text(widget.item.name,style: TextStyle(fontSize:size.width*0.05 ,fontFamily:StringConstant.font,fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left:size.width*0.04,bottom: size.width*0.01,right: size.width*0.02),
                      child: Row(children: [
                        Text(widget.item.price,style: TextStyle(fontSize: size.width*0.055 ,fontFamily:StringConstant.font,fontWeight: FontWeight.bold)),
                        Expanded(child: SizedBox(width: size.width*0.4)),
                       ShoppingCounter(quantity:widget.item.quantity,
              onItemsChanged: (items) {
                setState(() {
                  numberOfItems = items;
                });
              },
            ),])),
                    Padding(padding:  EdgeInsets.only(left:size.width*0.04,bottom: size.width*0.02),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RatingBarWidget(rating: 2.5,),
                          SizedBox(width: size.width*0.005,),
                          Text("(0 Reviews)",style: TextStyle(fontFamily: StringConstant.font,fontSize: size.width*0.03))])),
                          Padding(
                      padding: EdgeInsets.only(left: size.width*0.04,bottom: size.width*0.02),
                      child: Text("Description",textAlign: TextAlign.center,style: TextStyle(fontSize: size.width*0.05 ,fontFamily:StringConstant.font,fontWeight: FontWeight.bold))),
                        Padding(
                          padding: EdgeInsets.only(left: size.width*0.04,bottom: size.width*0.02),
                          child: Text(StringConstant.dummyString,style: TextStyle(fontSize: size.width*0.04 ,fontFamily:StringConstant.font,fontWeight: FontWeight.normal))),
                    Padding(
                      padding: EdgeInsets.only(left:size.width*0.04,bottom: size.width*0.08,right: size.width*0.04,top: size.width*0.02),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(decoration: BoxDecoration(color: const Color.fromARGB(153, 160, 174, 171),borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding:  EdgeInsets.all(size.width*0.01),
                            child: InkWell(child: Icon(isBookmarked
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                size: size.width * 0.07,
                              ),
                               onTap: () {
                              setState(() {
                                isBookmarked = !isBookmarked;
                              });
                              final bookmarkProvider = Provider.of<BookmarkProvider>(context, listen: false);
                            final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
                            final userId = userDataProvider.profileData.uid;
                            if (isBookmarked) {
                              bookmarkProvider.toggleBookmark(context, widget.item,userId);
                            } else {
                             
                            }}),
                          )),
                          SizedBox(width: size.width*0.02),
                          Expanded(child: CustomButton(color: Colors.white,text: 'ADD TO CART',onTap: () {
                            Provider.of<AddtoCartProvider>(context, listen: false).toggleAddtoCart(context,widget.item,5);
                          }))]))]))))]));  
  }
}