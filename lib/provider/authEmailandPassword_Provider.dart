import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AuthServiceEmailPassword extends ChangeNotifier {
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  
  Future<UserCredential> signInWithEmailandPassword(String email, String password) async {
    try {
      UserCredential usercredential = await firebaseauth.signInWithEmailAndPassword(email: email, password: password);
        return usercredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> registerWithEmailandPassword(String email,String password, String name, String birthday, String address,String phone,String brand,String img) async {
    try {
      UserCredential usercredential = await firebaseauth.createUserWithEmailAndPassword(email: email, password: password);
      String? token = await FirebaseMessaging.instance.getToken();
      fireStore.collection('users').doc(usercredential.user!.uid).set({
        'uid': usercredential.user!.uid,
        'password': password,
        'email': email,
        'name': name,
        'phone':phone,
        'birthday': birthday,
        'address': address,
        'brand': brand,
        'bookmark':[],
        'img':'',
        'admin':'',
        'token':token
      });  
      return usercredential;
    } 
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    notifyListeners();
    return await FirebaseAuth.instance.signOut();
  }
}