import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/profilemodel.dart';
import '../views/onBoarding/login.dart';
import '../widgets/custom_showdialog.dart';
import 'authEmailandPassword_Provider.dart';
import 'person_provider.dart'; 

class ProfileProvider extends ChangeNotifier {
  late UserDataProvider userDataProvider;

  ProfileProvider(BuildContext? context) {
   initializeUserDataProvider(context!);
  }

  void initializeUserDataProvider(BuildContext context) {
    userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
  }

  List<ProfileModel> profileDataList = [];
  void updateProfileDataList(BuildContext context) {
    profileDataList = [
      ProfileModel(title: "Name", value: userDataProvider.profileData.name, icon: const Icon(Icons.person)),
      ProfileModel(title: "Email", value: userDataProvider.profileData.email, icon: const Icon(Icons.email)),
      ProfileModel(title: "Phone no.", value: userDataProvider.profileData.phoneno, icon: const Icon(Icons.phone_android)),
      ProfileModel(title: "Address", value: userDataProvider.profileData.address, icon: const Icon(Icons.place)),
      ProfileModel(title: "Birthday", value: userDataProvider.profileData.birthday, icon: const Icon(Icons.cake)),
    ];
  }

   void signOut(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
      return CustomDeleteConfirmationDialog(
        onCancel: () {
        Navigator.of(context).pop();
      },
      onConfirm:  () {
        final authService =
        Provider.of<AuthServiceEmailPassword>(context, listen: false);
        authService.signOut();
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return const LoginInScreen();
        }), (route) => false);
      }, 
      button1text: 'No', button2text: 'Yes', description: 'Are you sure you want to logout?', heading: 'Log Out', );}
    );
  }
}
