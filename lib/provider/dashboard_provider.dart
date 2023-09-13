import 'package:ecommerse/utils/color_constant.dart';
import 'package:ecommerse/views/dashboard/home/admin/adminHomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../views/dashboard/bookmark/bookmark.dart';
import '../views/dashboard/home/home_screen.dart';
import '../views/dashboard/orderhistory/orderlist_history_page.dart';
import '../views/dashboard/orderhistory/orderlistvendor_history.dart';
import '../views/dashboard/profile/profile_page.dart';

import 'person_provider.dart';

class DashboardProvider with ChangeNotifier {

   List<Widget> usertype=[];

  final List<Widget> customerWidgets = [
    const HomeScreen(),
    const ProfilePage(),
    const HistoryPage(),
    BookmarkPage(),
  ];

  final List<Widget> vendorWidgets = [
    const HomeScreen(),
    const ProfilePage(),
    const HistoryPageVendor(),
  ];

  final List<Widget> adminWidgets = [
    const AdminScreen(),
    const ProfilePage(),
  ];

  List<BottomNavigationBarItem> bottomNavigationBarItems = [];
  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }


 void role(BuildContext context){
  final userData = Provider.of<UserDataProvider>(context).profileData;
  String userRole=  userData.admin.isNotEmpty?'admin':userData.brand.isNotEmpty?'vendor':'customer';
    setRole(userRole);
 }
  void setRole(String role) {
    switch (role) {
      case 'customer':
      usertype=customerWidgets;
        bottomNavigationBarItems = const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: ColorConstant.primaryColor),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: ColorConstant.primaryColor),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
            backgroundColor: ColorConstant.primaryColor),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'BookMark',
            backgroundColor: ColorConstant.primaryColor),
        ];
        break;
      case 'vendor':
      usertype=vendorWidgets;
        bottomNavigationBarItems = const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: ColorConstant.primaryColor),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: ColorConstant.primaryColor),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
            backgroundColor: ColorConstant.primaryColor),
        ];
        break;
      case 'admin':
      usertype=adminWidgets;
        bottomNavigationBarItems = const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: ColorConstant.primaryColor),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: ColorConstant.primaryColor),
        ];
        break;
      default:
        bottomNavigationBarItems = [];
        break;
    }
  }
}
