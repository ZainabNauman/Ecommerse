import 'package:flutter/material.dart';

import '../utils/string_constant.dart';

class CustomTextFieldCredential extends StatelessWidget {
  final TextEditingController? controller;
  final bool isObscure;
  final String hint;
  final Icon icon;
  final Widget? sufixicon;
  final String text;
  final TextInputType? textInputType;
  const CustomTextFieldCredential(
      {super.key,
      required this.hint,
      this.controller,
      required this.icon,
      this.sufixicon,
      required this.isObscure,
      required this.text,
      this.textInputType});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
          style: TextStyle(color: Colors.grey.shade400,fontFamily: StringConstant.font),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          obscureText: isObscure,
          keyboardType: textInputType,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontFamily: StringConstant.font),
            prefixIconColor: Colors.grey.shade400,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)),
              prefixIcon: icon,
              suffixIconColor: Colors.grey.shade400,
              suffixIcon: sufixicon),
        )]);
  }
}