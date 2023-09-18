import 'package:ecommerse/models/item_model.dart';
import 'package:ecommerse/provider/addtocart_provider.dart';
import 'package:ecommerse/utils/color_constant.dart';
import 'package:ecommerse/utils/helper_function.dart';
import 'package:ecommerse/utils/string_constant.dart';
import 'package:ecommerse/views/dashboard/home/itemDetail/itemcounter.dart';
import 'package:ecommerse/widgets/custom_appbar.dart';
import 'package:ecommerse/widgets/custom_chachenetwork_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/bookmark_provider.dart';
import '../../../../provider/person_provider.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/ratingbar.dart';

// ignore: must_be_immutable
class IndividualItem extends StatefulWidget{ 
  ItemModel item;
  IndividualItem({super.key,required this.item});

  @override
  State<IndividualItem> createState() => _IndividualItemState();
}

class _IndividualItemState extends State<IndividualItem> {
  bool isBookmarked = false;
  int numberOfItems =1;

  @override
  void initState() {
    super.initState();
    final bookmarkProvider = Provider.of<BookmarkProvider>(context, listen: false);
    isBookmarked = bookmarkProvider.isBookmarked(widget.item.id);
  }

  @override
  Widget build(BuildContext context) {   
    Size size = responseMediaQuery(context);
    return Scaffold(
      appBar: const CustomAppBar(title: 'Order Details'),
      body: Column(children: [
          Expanded(flex: 5,child: CustomCachedNetworkImage(imageUrl: widget.item.img)),
          Expanded(flex: 5,
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,children: [
                  Padding(padding: EdgeInsets.only(top: size.width*0.04,left:size.width*0.04,bottom: size.width*0.01),
                    child: Text(widget.item.name,style: TextStyle(fontSize:size.width*0.045,fontFamily:StringConstant.font,fontWeight: FontWeight.bold))),
                  Padding(padding: EdgeInsets.only(left:size.width*0.04,bottom: size.width*0.01,right: size.width*0.04),
                    child: Row(children: [ 
                      Text('\$ ',style: TextStyle(fontSize: size.width*0.04 ,fontFamily:StringConstant.font,fontWeight: FontWeight.bold)),
                      Text(widget.item.price,style: TextStyle(fontSize: size.width*0.04 ,fontFamily:StringConstant.font,fontWeight: FontWeight.bold)),
                      Expanded(child: SizedBox(width: size.width*0.4)),
                      ShoppingCounter(quantity:widget.item.quantity,
                        onItemsChanged: (items) {
                          setState(() {
                            numberOfItems = items;
                          });
                        })])),
                  Padding(padding:  EdgeInsets.only(left:size.width*0.04,bottom: size.width*0.02),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center,children: [
                      RatingBarWidget(rating: 2.5,),
                      SizedBox(width: size.width*0.005,),
                      Text("(0 Reviews)",style: TextStyle(fontFamily: StringConstant.font,fontSize: size.width*0.03))])),
                  Padding(padding: EdgeInsets.only(left: size.width*0.04,bottom: size.width*0.02),
                    child: Text("Description:",textAlign: TextAlign.center,style: TextStyle(fontSize: size.width*0.03 ,fontFamily:StringConstant.font,fontWeight: FontWeight.bold))),
                  Padding(padding: EdgeInsets.only(left: size.width*0.04,bottom: size.width*0.02,right: size.width*0.04),
                    child: Text(StringConstant.dummyString,style: TextStyle(fontSize: size.width*0.03 ,fontFamily:StringConstant.font,fontWeight: FontWeight.normal))),
                  SizedBox(width: size.width*0.04),
                  Padding(padding: EdgeInsets.only(left:size.width*0.04,bottom: size.width*0.04,right: size.width*0.04,top: size.width*0.02),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center,children: [
                      Container(decoration: BoxDecoration(color: ColorConstant.secondaryLightColor,borderRadius: BorderRadius.circular(5)),
                        child: Padding(padding:  const EdgeInsets.all(10),
                          child: GestureDetector(
                            child: Icon(isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              size: 25),
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
                              bookmarkProvider.removeItemFromBookMark(context, widget.item,userId);
                              }
                            }))),
                      SizedBox(width: size.width*0.02),
                      Expanded(child: CustomButton(color: Colors.white,text: 'ADD TO CART',
                      onTap: () async {
                        final cartProvider = Provider.of<AddtoCartProvider>(context,listen: false);                     
                        cartProvider.toggleAddtoCart(context, widget.item,numberOfItems);
                      }))]))])))]));  
  }  
}