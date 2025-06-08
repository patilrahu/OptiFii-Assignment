import 'package:flutter/material.dart';
import 'package:remburshiment_app/widgets/app_button.dart';

class AppPopUp {
  static Future<void> showPopUpDialog(BuildContext context, VoidCallback onTap,
      String buttonTitle, Widget mainContent) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: mainContent,
          actions: <Widget>[AppButton(text: buttonTitle, onPressed: onTap)],
        );
      },
    );
  }
}
