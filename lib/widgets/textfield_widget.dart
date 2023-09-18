import 'package:flutter/material.dart';

import '../utils/media_query.dart';
import '../utils/string_constant.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearchChanged; 
  const CustomTextField({Key? key, required this.controller, required this.onSearchChanged}): super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = displayWidth(context);
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      onChanged: onSearchChanged, 
      decoration: InputDecoration(
        hintText: StringConstant.searchString,
        hintStyle: TextStyle(fontFamily: StringConstant.font, color: Colors.black),
        suffixIcon: IconButton(
          splashRadius: width * 0.03,
          icon: const Icon(Icons.clear, color: Colors.black),
          onPressed: () { 
            controller.clear();
            onSearchChanged("");
          }),
        prefixIcon: IconButton(
          splashRadius: width * 0.03,
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () {},
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.0),
        )));
  }
}
