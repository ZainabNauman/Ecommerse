import 'package:ecommerse/views/dashboard/home/itemDetail/itemcounter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/addtocart_provider.dart';
import '../../../../provider/person_provider.dart';
import '../../../../utils/helper_function.dart';
import '../../../../utils/responsive_class.dart';
import '../../../../utils/string_constant.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_chachenetwork_image.dart';
import '../../../../widgets/custom_showdialog.dart';
import '../../../../widgets/ratingbar.dart';

class AddtoCart extends StatefulWidget {
  AddtoCart({Key? key});

  @override
  State<AddtoCart> createState() => _AddtoCartState();
}

class _AddtoCartState extends State<AddtoCart> {

  @override
  void initState() {
    super.initState();
    final cartProvider = Provider.of<AddtoCartProvider>(context, listen: false);
    cartProvider.fetchCartItems(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = responseMediaQuery(context);
    final cartProvider = Provider.of<AddtoCartProvider>(context);
    final cartItems = cartProvider.cartItems;
    final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    final userId = userDataProvider.profileData.uid;
    int numberOfItems = 0;
    return Scaffold(
      appBar: const CustomAppBar(title: 'My Cart'),
      body: Row(children: [
        if (!Responsive.isMobile(context))
          Expanded(flex: 2, child: Container()),
          Expanded(flex: 6,
            child: Column(children: [
              Expanded(
                child: cartItems.isEmpty
                  ? Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_shopping_cart, size: size.width * 0.1),
                        Text('Your cart is empty.',style: TextStyle(fontSize: size.width * 0.05))]))
                  : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final totalQuantity = cartProvider.itemQuantities[item.id];
                      return Dismissible(
                        key: Key(item.id),
                        confirmDismiss: (direction) async {
                          final confirmed = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDeleteConfirmationDialog(
                                onCancel: () {
                                  Navigator.of(context).pop(false);
                                },
                                onConfirm: () async {
                                  cartProvider.removeItemFromCart(context, item);
                                  Navigator.of(context).pop(true);
                                  setState(() {});
                                },
                                button1text: StringConstant.button1text,
                                button2text: StringConstant.button2text,
                                description: StringConstant.description,
                                heading: StringConstant.heading,
                              );
                            });
                          return confirmed ?? false;
                        },
                        direction: DismissDirection.endToStart,
                        background: Padding(padding: EdgeInsets.fromLTRB(size.width * 0.04, size.width * 0.025, size.width * 0.04, size.width * 0.025),
                          child: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20.0),
                            child: const Icon(Icons.delete, color: Colors.white))),
                        child: Padding(padding: EdgeInsets.fromLTRB(size.width * 0.04, size.width * 0.025, size.width * 0.04, size.width * 0.025),
                          child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.black)),
                            child: Padding(padding: EdgeInsets.only(right: size.width * 0.04, left: size.width * 0.04, top: size.width * 0.025, bottom: size.width * 0.025),
                              child: Row(children: [
                                Expanded(flex: 3,
                                  child: Container(height: size.width * 0.25,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(70)),
                                    child: ClipRRect(borderRadius: BorderRadius.circular(70),
                                      child: CustomCachedNetworkImage(imageUrl: item.img)))),
                                Expanded(flex: 6,
                                  child: Padding(padding: EdgeInsets.only(left: size.width * 0.02),
                                    child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,children: [
                                      Text(item.name,style: TextStyle(fontFamily: StringConstant.font, fontWeight: FontWeight.bold, fontSize: size.width * 0.05)),
                                      Text('\$${item.price}',style: TextStyle(fontFamily: StringConstant.font, fontWeight: FontWeight.normal, fontSize: size.width * 0.04)),
                                      Text(item.brand,style: TextStyle(fontFamily: StringConstant.font, fontWeight: FontWeight.normal, fontSize: size.width * 0.04)),
                                      Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                        RatingBarWidget(),
                                        Text("(0 Reviews)",style: TextStyle(fontFamily: StringConstant.font, fontWeight: FontWeight.normal, fontSize: size.width * 0.03))]),
                                      Row(children: [
                                        Text('Quantity:  ',style: TextStyle(fontFamily: StringConstant.font, fontWeight: FontWeight.normal, fontSize: size.width * 0.04)),
                                        Padding(padding: EdgeInsets.only(top: size.width*0.015),
                                          child: ShoppingCounter(
                                            quantity: totalQuantity!,
                                            presentCartCount: item.quantity,
                                            onItemsChanged: (items) {
                                              setState(() {
                                                numberOfItems = items;
                                              });
                                              cartProvider.updateItemQuantity(context,item,numberOfItems);
                                            }))])]))),
                                Expanded(flex: 1,
                                  child: InkWell(
                                    onTap: () async {
                                      final confirmed = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDeleteConfirmationDialog(
                                            onCancel: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            onConfirm: () async {
                                              cartProvider.removeItemFromCart(context, item);
                                              Navigator.of(context).pop(true);
                                              setState(() {});
                                            },
                                            button1text: StringConstant.button1text,
                                            button2text: StringConstant.button2text,
                                            description: StringConstant.description,
                                            heading: StringConstant.heading);
                                        });
                                        if (confirmed ?? false) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item removed from cart')));
                                        }},
                                        child: const Icon(Icons.delete, color: Colors.red)))])))));
                    })),
              Padding(padding: EdgeInsets.all(size.width * 0.02),
                  child: CustomButton(text: 'Place Order',
                      onTap: () async {
                        await cartProvider.placeOrder(context, cartProvider, userId);
                      }))])),
            if (!Responsive.isMobile(context)) Expanded(flex: 2, child: Container())]));
  }
}