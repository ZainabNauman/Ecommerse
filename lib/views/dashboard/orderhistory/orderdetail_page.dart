import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse/utils/color_constant.dart';
import 'package:ecommerse/utils/helper_function.dart';
import 'package:flutter/material.dart';

import '../../../utils/string_constant.dart';
import '../../../widgets/custom_appbar.dart';
import 'order_status.dart';

class OrderDetailPage extends StatefulWidget {
  final String orderId;
  OrderDetailPage({super.key, required this.orderId});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  List<Map<String, dynamic>> orderDetails = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    displayOrders();
  }
  @override
  Widget build(BuildContext context) {
    Size size = responseMediaQuery(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'Order Details'),
      body: Padding(padding: EdgeInsets.all(size.width * 0.03),
        child: isLoading
            ? const Center(child: CircularProgressIndicator(color: ColorConstant.primaryColor, strokeWidth: 2))
            : SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.transparent),
                  child: Padding(padding: EdgeInsets.all(size.width * 0.03),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                        for (var orderDetail in orderDetails) ...[
                          Text('Order # ${orderDetail['orderId']}',
                            style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.bold,fontSize: size.width*0.045)),
                          SizedBox(height: size.width * 0.04),
                          OrderStatus(
                            orderId: orderDetail['orderId'],
                            orderStatus: orderDetail['status'],
                            onStatusChanged: (newStatus) {
                              print('Order status changed to $newStatus');
                            }),
                          const SizedBox(height: 16.0),
                          Card(
                            elevation: 10,
                            child: Padding(padding: EdgeInsets.all(size.width * 0.01),
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                    Padding(padding: const EdgeInsets.all(16.0),
                                      child: Text('Order Items',style: TextStyle(fontSize: size.width*0.05,fontWeight: FontWeight.bold,fontFamily: StringConstant.font))),
                                    const Divider(thickness: 1.0, color: Colors.grey),
                                    DataTable(
                                      columnSpacing: size.width*0.04,
                                      columns: [
                                        DataColumn(label: Text("Product",style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.bold))),
                                        DataColumn(label: Text("Quantity",style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.bold))),
                                        DataColumn(label: Text("Price",style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.bold))),
                                        DataColumn(label: Text("Subtotal",style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.bold)))],
                                      rows: getProductDetailsRows(orderDetail['productDetails']),
                                    )]))))]]))))));
  }

  List<DataRow> getProductDetailsRows(List<Map<String, dynamic>> productDetails) {
    List<DataRow> rows = [];
    double totalAmount = 0.0;
    for (var detail in productDetails) {
      final productName = detail['productName'];
      final productQuantity = detail['productQuantity'];
      final productPrice = detail['productPrice'];
      final subtotal = productPrice * productQuantity;
      totalAmount += subtotal;
      rows.add(DataRow(
        cells: [
          DataCell(Text(productName,style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.bold))),
          DataCell(Text(productQuantity.toString(),style: TextStyle(fontFamily: StringConstant.font))),
          DataCell(Text('\$${productPrice.toStringAsFixed(2)}',style: TextStyle(fontFamily: StringConstant.font))),
          DataCell(Text('\$${subtotal.toStringAsFixed(2)}',style: TextStyle(fontFamily: StringConstant.font)))]));
    }
    rows.add(DataRow(
      cells: [
        DataCell(Text("Total", style: TextStyle(fontWeight: FontWeight.bold,fontFamily: StringConstant.font))),
        const DataCell(Text("")),
        const DataCell(Text("")),
        DataCell(Text('\$${totalAmount.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold,fontFamily: StringConstant.font)))]));
    return rows;
  }
 

  Future<void> displayOrders() async {
    final orders = await fetchItemData(widget.orderId);
    final orderId = orders!.id;
    final status = orders['status'];
    final userId = orders['userId'];
    final orderItems = orders['orderItems'];
    final productDetails = <Map<String, dynamic>>[];
    for (final item in orderItems) {
      final productId = item['productId'];
      final productQuantity = item['productQuantity'];
      final productName = await fetchProductName(productId);
      final productPrice = await fetchProductPrice(productId);
      productDetails.add({
        'productName': productName,
        'productPrice': productPrice,
        'productQuantity': productQuantity,
      });
    }
    orderDetails.add({
      'orderId': orderId,
      'status': status,
      'userId': userId,
      'productDetails': productDetails,
    });
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<DocumentSnapshot?> fetchItemData(String orderId) async {
    try {
      final itemDoc =
          await FirebaseFirestore.instance.collection('orders').doc(orderId).get();
      return itemDoc;
    } catch (e) {
      print('Error fetching item data: $e');
      return null;
    }
  }

  Future<String?> fetchProductName(String productId) async {
    try {
      final itemDoc = await FirebaseFirestore.instance.collection('items').doc(productId).get();
      return itemDoc['name'];
    } catch (e) {
      print('Error fetching product name: $e');
      return null;
    }
  }

  Future<double> fetchProductPrice(String productId) async {
    try {
      final itemDoc = await FirebaseFirestore.instance.collection('items').doc(productId).get();
      return double.parse(itemDoc['price']) ;
    } catch (e) {
      print('Error fetching product price: $e');
      return 0.0;
    }
  }
}
