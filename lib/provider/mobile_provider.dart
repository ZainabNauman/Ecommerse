import 'package:flutter/material.dart';

class MobileLayoutProvider with ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  int count = 0;

  void handleCategoryTapped(int index) {
    count = index;
    notifyListeners();
  }
}
