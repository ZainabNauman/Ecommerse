import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse/utils/color_constant.dart';
import 'package:ecommerse/utils/helper_function.dart';
import 'package:ecommerse/utils/responsive_class.dart';
import 'package:ecommerse/utils/string_constant.dart';
import 'package:ecommerse/widgets/ratingbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../models/item_model.dart';
import '../../../provider/addtocart_provider.dart';
import '../../../provider/person_provider.dart';
import '../../../widgets/custom_chachenetwork_image.dart';
import '../../../widgets/custom_showdialog.dart';
import 'itemDetail/itemdetail_desktopscreen.dart';
import 'itemDetail/itemdetail_screen.dart';

class ItemGridView extends StatefulWidget {
  final List<ItemModel> items;
  
  const ItemGridView(this.items, {super.key}); 
  @override
  State<ItemGridView> createState() => _ItemGridViewState();
}

class _ItemGridViewState extends State<ItemGridView> {
  @override
  Widget build(BuildContext context) {  
    final userDataProvider = Provider.of<UserDataProvider>(context,listen: false);
    Size size = responseMediaQuery(context);
    return 
    Padding(padding: EdgeInsets.only(left:size.width*0.05,right:size.width*0.05),
      child: StaggeredGridView.countBuilder(
          crossAxisCount: 
          Responsive.isMobile(context)?2
          :Responsive.isTablet(context)?2
          :3,
          itemCount: widget.items.length,
          itemBuilder: (BuildContext context, int index) => Stack(children:[ 
            SizedBox(
              child: Padding(padding: EdgeInsets.all(size.width*0.01),
                child: Card(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) {
                          return Responsive.isMobile(context) 
                            ?IndividualItem(item:widget.items[index])
                            :IndividualItemDesktop(item:widget.items[index]);
                        }));
                    },
                    child: Stack(children: [
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                            Center(child: CustomCachedNetworkImage(imageUrl: widget.items[index].img,errorHeight: size.width*0.3)),
                            const Divider(height:1,color: Colors.black,indent: 5,endIndent: 5,thickness: 0.08),
                            Padding(padding: EdgeInsets.only(top: size.width*0.01,left: size.width*0.02,right:size.width*0.02,bottom:size.width*0.01),
                              child: Text(widget.items[index].name,style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.bold))),
                            Padding(padding: EdgeInsets.only(left: size.width*0.02,right:size.width*0.02,bottom:size.width*0.01,top: size.width*0.01),
                              child: Text(widget.items[index].price,style: TextStyle(fontFamily: StringConstant.font))),
                            Padding(padding: EdgeInsets.only(top: size.width*0.01,left: size.width*0.02,right:size.width*0.02,bottom:size.width*0.01),
                              child: Row(children: [
                                RatingBarWidget(rating: 2.5),
                                SizedBox(width: size.width*0.007),
                                Expanded(child: Text("(0 Reviews)",style: TextStyle(fontFamily: StringConstant.font,fontSize: size.width*0.025)))]))]))]))))),
                                if(userDataProvider.profileData.brand.isEmpty)
                                Positioned( top: 0,right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return Responsive.isMobile(context) ? IndividualItem(item: widget.items[index]) : IndividualItemDesktop(item: widget.items[index]);
                                      }));
                                    },
                                    child: Material(
                                      elevation: 10,
                                      shape:CircleBorder(),
                                      child: InkWell(
                                        onTap: () {
                                          Provider.of<AddtoCartProvider>(context, listen: false).toggleAddtoCart(context,widget.items[index],1);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
                                          child: Padding(padding: const EdgeInsets.all(6.0),
                                            child: Icon(Icons.shopping_cart_outlined,color: ColorConstant.primaryColor,size: size.width*0.04))))))),
                                if(userDataProvider.profileData.brand.isNotEmpty)
                                  Positioned(top: 0,right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return Responsive.isMobile(context) ? IndividualItem(item: widget.items[index]) : IndividualItemDesktop(item: widget.items[index]);
                                        }));
                                      },
                                      child: Material(
                                        elevation: 10,
                                        shape: CircleBorder(),
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                              return CustomDeleteConfirmationDialog(
                                                onCancel: () {
                                                Navigator.of(context).pop();
                                              },
                                              onConfirm:  () {
                                                removeItemFromFirestore(widget.items[index].name);
                                                setState(() {
                                                  widget.items.removeAt(index);
                                                });
                                                Navigator.of(context).pop();
                                              }, 
                                              button1text: 'No', button2text: 'Yes', description: 'Are you sure you want to Delete?', heading: 'DeleteItem');
                                              });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
                                            child: Padding(padding: const EdgeInsets.all(6.0),
                                              child: Icon(Icons.remove,color: ColorConstant.primaryColor,size: size.width*0.04)))))))]),
        staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0));
  }
  Future<void> removeItemFromFirestore(String name) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('items').where('name', isEqualTo: name).get();
      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        await documentSnapshot.reference.delete();
        print('Item removed from Firestore');
      } else {
        print('Item with name $name not found.');
      }
    } catch (e) {
      print('Error removing item from Firestore: $e');
    }
  }
}