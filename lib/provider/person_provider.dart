import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse/views/dashboard/dashboard_screen.dart';
import 'package:ecommerse/views/onBoarding/login.dart';
import 'package:ecommerse/views/onBoarding/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/person_model.dart';
import '../utils/string_constant.dart';
import 'authEmailandPassword_Provider.dart';

class UserDataProvider extends ChangeNotifier {
  PersonModel profileData = PersonModel(name: '', email: '', password: '', phoneno: '', address: '', birthday: '', brand: '', uid:'', bookmark: [], admin: '', img:'');
  bool loginLoader = false;
  bool loginIsobscure = true;
  bool signUpLoader = false;
  bool signUpIsobscure = true;
  bool signUpIsCkecked = false;

  void changeloginIsobscure(bool value){
    loginIsobscure = value;
    notifyListeners();
  }

  void changeloginLoader(bool value){
    loginLoader = value;
    notifyListeners();
  }

  Future<void> getCurrentUserAndFetchData(BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final fetchedData = await fetchUserData(currentUser);
      if (fetchedData != null) {
        profileData = PersonModel(name: fetchedData.name, email: fetchedData.email, password: fetchedData.password, phoneno: fetchedData.phoneno,
          address: fetchedData.address, birthday: fetchedData.birthday, uid: fetchedData.uid, brand: fetchedData.brand.isEmpty ? '' : fetchedData.brand,
          bookmark: fetchedData.bookmark.isEmpty? []:fetchedData.bookmark, admin: fetchedData.admin,img: fetchedData.img);        
        changeloginLoader(false);
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DashboardScreen()) , (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginInScreen()) , (route) => false);
      }
    } else {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginInScreen()) , (route) => false);
    }
  }

  Future<PersonModel?> fetchUserData(user) async {
    if (user == null) {
      return null;
    }
    try {
      final DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userData.exists) {
        final Map<String, dynamic> data = userData.data() as Map<String, dynamic>;
        final PersonModel profile = PersonModel(name: data['name'] ?? '', email: data['email'] ?? '', password: data['password'] ?? '',
          phoneno: data['phone'] ?? '', address: data['address'] ?? '', birthday: data['birthday'] ?? '', brand: data['brand'] ?? '', 
          uid: data['uid'] ?? '', bookmark: data['bookmark'] ?? '', admin:data['admin'], img: data['img'] ?? '');
        return profile;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }
   ///////// login
  void signInTap(BuildContext context, String email, String pass){
    if (email.isEmpty || !RegExp(StringConstant.emailpattern).hasMatch(email)) {
      showpopup(context, StringConstant.alert, StringConstant.alertDesc);
    } else if (pass.isEmpty || pass.length < 8) {
      showpopup(context, StringConstant.alert, StringConstant.alertDesc);
    } else {
      signin(context, email, pass);
    }
  }
    
  void signin(BuildContext context, String email, String pass) async {
    changeloginLoader(true);
    final authEmailPassword = Provider.of<AuthServiceEmailPassword>(context, listen: false);
    try {
      await authEmailPassword.signInWithEmailandPassword(email, pass);
      await storeNotificationToken();
      await getCurrentUserAndFetchData(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      changeloginLoader(false);
    }
  }

  storeNotificationToken()async{
    String? token = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(
        {
          'token': token
        },SetOptions(merge: true));
  }


   void showpopup(BuildContext context, String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(title: Text(title), content: Text(message));
        });
  }
  //////////sign up
  void changesignUpIsCkecked(bool value){
    signUpIsCkecked = value;
    notifyListeners();
  }
  
  void changesignUpLoader(bool value){
    signUpLoader = value;
    notifyListeners();
  }

  void changesignUpIsobscure(bool value){
    signUpIsobscure = value;
    notifyListeners();
  }

  Future<void> getCurrentUserAndFetchDataForSignUp(BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final fetchedData = await fetchUserData(currentUser);
      if (fetchedData != null) {
        profileData = PersonModel(name: fetchedData.name, email: fetchedData.email, password: fetchedData.password,
          phoneno: fetchedData.phoneno, address: fetchedData.address, birthday: fetchedData.birthday, uid: fetchedData.uid,
          brand: fetchedData.brand.isEmpty ? '' : fetchedData.brand,
          bookmark: fetchedData.bookmark, admin: fetchedData.admin, img: fetchedData.img);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DashboardScreen()) , (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignUpScreen()) , (route) => false);
      }
    } else {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignUpScreen()) , (route) => false);
    }
  }

  void signUpTap(BuildContext context, String email, String pass,String name, String birthday,String address,String phone,String brand,String img){
    if (name.isEmpty ||!RegExp(StringConstant.namepattern).hasMatch(name)) {
      showpopup(context, StringConstant.alert, "Invalid Name");
    } else if (email.isEmpty || !RegExp(StringConstant.emailpattern).hasMatch(email)) {
      showpopup(context, StringConstant.alert, "Invalid Email");
    } else if (pass.isEmpty ||pass.length < 8) {
      showpopup(context, StringConstant.alert, "Invalid password");
    } else if (phone.isEmpty) {
      showpopup(context, StringConstant.alert, "Invalid Phone Number");
    } else if (address.isEmpty) {
      showpopup(context, StringConstant.alert, "Invalid Address");
    } else if (birthday.isEmpty) {
      showpopup(context, StringConstant.alert, "Invalid Birth Date");
    } else if (signUpIsCkecked==false) {
      showpopup(context, StringConstant.alert, "Agree to Conditions");
    } else {
      signup(context, email, pass, name,  birthday, address, phone, brand,img);
    }
  }
  
  void signup(BuildContext context, String email, String pass,String name,String birthday,String address,String phone,String brand,String img) async {
    changesignUpLoader(true);
    final authEmailPassword =Provider.of<AuthServiceEmailPassword>(context, listen: false);
    try {
      await authEmailPassword.registerWithEmailandPassword(email,pass,name,birthday,address,phone,brand,img);
      await getCurrentUserAndFetchDataForSignUp(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      changesignUpLoader(false);
    }
  }
  ///////////edit Profile
  Future<void> getEditProfileData(BuildContext context,String name,String email,String phoneno,String address,String birthday) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final fetchedData = await fetchUserData(currentUser);
      if (fetchedData != null) {
        profileData = PersonModel(name: name, email: email, password: fetchedData.password, phoneno: phoneno, address: address, 
          birthday: birthday,uid: currentUser.uid, brand: fetchedData.brand.isEmpty ? '' : fetchedData.brand,
          bookmark: fetchedData.bookmark, admin: fetchedData.admin, img: fetchedData.img);
        print('Profile Data after fetchhhhhhhhhhh: ${profileData.brand}');
        notifyListeners();
      } else {
        print("Data not Inserted");
      }
    } else {
      print("Data is not inserted");
    }
  }
}
