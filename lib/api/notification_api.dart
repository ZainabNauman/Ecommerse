import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

Future<void> sendNotification(String userId, String orderId, String newStatus) async {
  final firebaseMessaging=FirebaseMessaging.instance;
  await firebaseMessaging.requestPermission();
  final itemDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
  final token= itemDoc['token'];
  const serverKey = "AAAA7Mxg2Iw:APA91bH9N7fUGQnQpxi34w9V0pHg9dyckp6jwtJZpfPELcxSFum7DZ7ZB4Nsbx9gwnVUwfAa6GncCBV2hAXAHpMW9BwJbqnh2VgBeQtrJjk9MyupJcPEYVFrTwj_sDC266XO8PluI2E9";
  final deviceToken = token;
  final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  final headers = {"Content-Type": "application/json", "Authorization": "key=$serverKey"};
  final notification = {"title": "Excuse Me", "body": "Your order $orderId status has been updated to $newStatus", "mutable_content": true, "sound": "Tri-tone"};
  final message = {"to": deviceToken, "notification": notification};
  final response = await http.post(url, headers: headers, body: jsonEncode(message));
  if (response.statusCode == 200) {
    print("Notification sent successfully!");
  } else {
    print("Failed to send notification. Status code: ${response.statusCode}");
    print("Response body: ${response.body}");
  }
}