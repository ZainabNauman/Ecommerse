import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse/provider/person_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profile_provider.dart';

class ProfileDataProvider extends ChangeNotifier {

  Future<void> updateProfileData(BuildContext context, String name,String birthday,String address,String phone,String email,String img) async {
    final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    final profileUserProvider = Provider.of<ProfileProvider>(context, listen: false);
    final userEmail = userDataProvider.profileData.email;
    final querySnapshot = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: userEmail).get();
    if (querySnapshot.docs.length == 1) {
    final userDocumentReference = querySnapshot.docs[0].reference;
    await userDocumentReference.update({
        "name": name,
        "birthday":birthday,
        "address":address,
        "phone":phone,
        "email":email,
        "img":img
      });
      userDataProvider.getEditProfileData(context, name, email, phone, address, birthday);
      profileUserProvider.updateProfileDataList(context);
      notifyListeners();
    } else {
      print('Error: Found ${querySnapshot.docs.length} documents with the same email.');
    }
  } 
}
