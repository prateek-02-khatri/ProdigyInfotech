import 'package:flutter/material.dart';

class Utils {
  static CustomAppBar(BuildContext context) {
    return AppBar(
      elevation: 15,
      titleSpacing: 20,
      title: Text(
        "To-Do List",
        style: Utils.CustomTextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Theme.of(context).primaryColor,
        ),
      ),
      actions: const <Widget> [
        Row(
         children: [
           Icon(Icons.more_vert, size: 30,),
           SizedBox(width: 10,)
         ],
        )
      ],
      backgroundColor: Colors.white,
      toolbarHeight: 65,
    );
  }

  static CustomTextStyle(
      {Color? color, double? fontSize, FontWeight? fontWeight, double? letterSpacing,}) {
    return TextStyle(
      fontFamily: "Times New Roman",
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? Colors.black,
      letterSpacing: letterSpacing ?? 0
    );
  }

  static CustomElevatedButton(
      {required VoidCallback onPressed, required String buttonName}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange.shade300,
        foregroundColor: Colors.black,
         
      ),
      child: Text(buttonName, style: CustomTextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
    );
  }
}
