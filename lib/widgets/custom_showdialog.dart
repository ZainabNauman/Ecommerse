import 'package:ecommerse/utils/color_constant.dart';
import 'package:flutter/material.dart';

class CustomDeleteConfirmationDialog extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final String description;
  final String heading;
  final String button1text;
  final String button2text;

  CustomDeleteConfirmationDialog({super.key, this.onCancel, this.onConfirm,required this.description,required this.heading,required this.button1text,required this.button2text});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                heading,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  
                  onPressed: onCancel,
                  child: Text(button1text),
                  style: ElevatedButton.styleFrom(backgroundColor:ColorConstant.primaryColor ),
                ),
                ElevatedButton(
                  onPressed: onConfirm,
                  child: Text(button2text),
                  style: ElevatedButton.styleFrom(backgroundColor:ColorConstant.primaryColor ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
