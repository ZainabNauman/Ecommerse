import 'package:ecommerse/utils/color_constant.dart';
import 'package:ecommerse/utils/string_constant.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color titleColor;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingIconPressed;

  CustomAppBar({
    required this.title,
    this.actions,
    this.titleColor = Colors.black,
    this.leadingIcon,
    this.onLeadingIconPressed,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstant.primaryColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20.0, // You can adjust the font size here
          fontFamily: StringConstant.font, // Replace with your desired font family
        ),
      ),
      leading: leadingIcon != null
          ? IconButton(
              icon: Icon(leadingIcon),
              onPressed: onLeadingIconPressed,
            )
          : null,
      actions: actions,
    );
  }
}
