import 'package:ecommerse/utils/color_constant.dart';
import 'package:ecommerse/utils/string_constant.dart';
import 'package:flutter/material.dart';

class ShoppingCounter extends StatefulWidget {
  final ValueChanged<int> onItemsChanged;
  final int quantity;
  final int presentCartCount;

  const ShoppingCounter({
    Key? key,
    required this.quantity,
    required this.onItemsChanged,
    this.presentCartCount=0
  }) : super(key: key);

  @override
  State<ShoppingCounter> createState() => _ShoppingCounterState();
}

class _ShoppingCounterState extends State<ShoppingCounter> {
  int numberOfItems = 0;

  @override
  void initState() {
    super.initState();
    numberOfItems = widget.presentCartCount != 0 ? widget.presentCartCount : 0;
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _shoppingItem()]);
  }

  Widget _shoppingItem() {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[
          _decrementButton(),
          SizedBox(width: size.width * 0.03),
          Text('$numberOfItems',style: TextStyle(fontFamily: StringConstant.font,fontSize: size.width * 0.04, color: Colors.black)),
          SizedBox(width: size.width * 0.03),
          _incrementButton()]));
  }

  Widget _incrementButton() {
    Size size = MediaQuery.of(context).size;
    bool isIncrementDisabled = numberOfItems >= widget.quantity; 
    return InkWell(
      onTap: () {
        if (!isIncrementDisabled) {
          setState(() {
            numberOfItems++;
          });
          widget.onItemsChanged(numberOfItems);
        }},
      child: Container(
        decoration: BoxDecoration(color: isIncrementDisabled ? Colors.red : ColorConstant.secondaryLightColor,borderRadius: BorderRadius.circular(5)),
        child: Padding(padding: EdgeInsets.all(size.width * 0.01),
          child: Icon(Icons.add,color: isIncrementDisabled ? ColorConstant.primaryColor : Colors.black))));
  }

  Widget _decrementButton() {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        setState(() {
          if (numberOfItems > 1) {
            numberOfItems--;
          }});
        widget.onItemsChanged(numberOfItems);
      },
      child: Container(
        decoration: BoxDecoration(color: ColorConstant.secondaryLightColor,borderRadius: BorderRadius.circular(5)),
        child: Padding(padding: EdgeInsets.all(size.width * 0.01),
          child: const Icon(Icons.remove, color: Colors.black))));
  }
}
