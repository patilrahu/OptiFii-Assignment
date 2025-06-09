import 'package:flutter/material.dart';

class NavigationHelper {
  static Future<void> push(
    BuildContext context,
    Widget screen, {
    void Function(dynamic result)? onResult,
  }) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    ).then((value) {
      if (onResult != null) {
        onResult(value);
      }
    });
    ;
  }

  static Future<void> pushRemoveUntil(
      BuildContext context, Widget screen) async {
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  static Future<void> pushReplacement(
      BuildContext context, Widget screen) async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static void popBottomSheet(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
