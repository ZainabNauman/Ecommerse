import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse/utils/color_constant.dart';
import 'package:ecommerse/utils/helper_function.dart';
import 'package:ecommerse/utils/string_constant.dart';
import 'package:ecommerse/widgets/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size=responseMediaQuery(context);
    final currentUser = FirebaseAuth.instance.currentUser;
    final customerUserId = currentUser?.uid;
    final CollectionReference notifyCollection = FirebaseFirestore.instance.collection('notifications');
    return Scaffold(
      appBar: const CustomAppBar(title: 'Notifications'),
      body: StreamBuilder<QuerySnapshot>(   
        stream: notifyCollection.where('userId', isEqualTo: customerUserId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Column(mainAxisAlignment: MainAxisAlignment.center,children: [
              Center(child: CircularProgressIndicator(color: ColorConstant.primaryColor,strokeWidth: 2))]);
          }
          final notifications = snapshot.data!.docs;
          notifications.sort((a, b) {
            final timestampA = (a.data() as Map<String, dynamic>)['timestamp'];
            final timestampB = (b.data() as Map<String, dynamic>)['timestamp'];
            return timestampB.compareTo(timestampA);
          });
          List<Widget> notificationWidgets = [];
          for (var notification in notifications) {
            final notificationData = notification.data() as Map<String, dynamic>;
            final message = notificationData['message'];
            final timestamp = notificationData['timestamp'];
            final status = notificationData['status'];
            notificationWidgets.add(
              Padding(padding: EdgeInsets.fromLTRB(size.width*0.04, size.width*0.02, size.width*0.04, size.width*0.02),
                child: Card(elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(size.width*0.0,size.width*0.05,size.width*0.03,size.width*0.05),
                    child: Row(children: [
                       Expanded(flex: 2,child: CircleAvatar(backgroundColor: ColorConstant.primaryColor,child: Icon(status=='placed'?Icons.stars_outlined:status=='on_the_way'? Icons.watch_later_outlined:Icons.done,color: Colors.white))),
                        Expanded(flex: 8,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                            Text(message,textAlign: TextAlign.justify,style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.normal,fontSize: size.width*0.03)),
                            SizedBox(height: size.width*0.02),
                            Text(timestamp,style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.w100,fontSize: size.width*0.03,color: Colors.grey))]))])))));
          }
          return Column(
            children: [
              SizedBox(height: size.width*0.03),
              Expanded(child: ListView(children: notificationWidgets)),
              SizedBox(height: size.width*0.03)
            ]);
        }));
  }
}