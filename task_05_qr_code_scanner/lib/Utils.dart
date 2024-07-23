import 'package:flutter/material.dart';

class Utils {

  static final Color bgColor = Colors.grey.shade300;

  static TextStyle customTextStyle({required double fontSize, required FontWeight fontWeight}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight
    );
  }

  static AppBar customAppBar({required String title}) {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
      ),
      toolbarHeight: 75,
    );
  }

  static customElevatedButton({required VoidCallback onPressed, required String text}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(275, 65)
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}