import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/person_provider.dart';
import '../../../utils/helper_function.dart';
import '../../../utils/string_constant.dart';

class VendorOrderStatus extends StatefulWidget {
  final String orderId;
  final String orderStatus;
  final String orderbrand;
  final ValueChanged<String> onStatusChanged;

  VendorOrderStatus({
    required this.orderId,
    required this.orderStatus,
    required this.onStatusChanged, required this.orderbrand,
  });

  @override
  _VendorOrderStatus createState() => _VendorOrderStatus();
}

class _VendorOrderStatus extends State<VendorOrderStatus> {
  String touchedStatus = ''; 
  

  bool isAdmin() {
    final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    return userDataProvider.profileData.admin.isNotEmpty;
  }

   bool isVendor() {
    final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    return userDataProvider.profileData.brand.isNotEmpty;
  }

  Future<String> _getOrderStatus() async {
    final orderDocRef = FirebaseFirestore.instance.collection('ordersforvendors').doc(widget.orderbrand).collection('vendororders').doc(widget.orderId);
    final orderDoc = await orderDocRef.get();
    return orderDoc.data()?['status'] ?? widget.orderStatus;
  }

  @override
  void initState() {
    super.initState();
    _getOrderStatus().then((status) {
      setState(() {
        touchedStatus = status; 
      });
    });
  }

  InkWell _buildCustomButton(String statusText,String status,IconData icon,Color defaultColor) {
    Size size = responseMediaQuery(context);
    bool isSelected = touchedStatus == status;
    Color buttonColor = isSelected ? ColorConstant.primaryColor : defaultColor;
    Color textColor = isSelected ? Colors.white : Colors.black; 
    return InkWell(
      onTap: isAdmin() || isVendor() ? () => _updateOrderStatus(status) : null,
      child: Container(
        width: size.width*0.2,
        height: size.width*0.2,
        decoration: BoxDecoration(color: buttonColor,borderRadius: BorderRadius.circular(50)),
        padding: EdgeInsets.all(size.width * 0.015),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon,color: textColor, size: size.width * 0.08),
            SizedBox(height: size.width * 0.01),
            Text(statusText,
            textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width * 0.03,
                fontFamily: StringConstant.font,
                fontWeight: FontWeight.bold,
                color: textColor))])));
  }
  @override
  Widget build(BuildContext context) {
    Size size=responseMediaQuery(context);
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
          _buildCustomButton('Placed', 'placed', Icons.stars_outlined, ColorConstant.secondaryLightColor),
           Expanded(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.grey),
                      height: size.width*0.005)),
          _buildCustomButton('On The Way', 'on_the_way', Icons.rotate_90_degrees_ccw_outlined, ColorConstant.secondaryLightColor),
           Expanded(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.grey),
                      height: size.width*0.005)),
          _buildCustomButton('Delivered', 'delivered', Icons.check_circle, ColorConstant.secondaryLightColor)]));
  }

  void _updateOrderStatus(String newStatus) {
    final orderDocRef = FirebaseFirestore.instance.collection('ordersforvendors').doc(widget.orderbrand).collection('vendororders').doc(widget.orderId);
    orderDocRef.update({'status': newStatus}).then((_) {
      setState(() {
        touchedStatus = newStatus; 
      });
      widget.onStatusChanged(newStatus); 
    }).catchError((error) {
      print('Error updating order status: $error');
    });
  }
}
