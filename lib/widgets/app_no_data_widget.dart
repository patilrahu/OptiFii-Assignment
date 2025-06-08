import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remburshiment_app/constant/color_code.dart';
import 'package:remburshiment_app/widgets/app_text.dart';

Widget noDataWidget(BuildContext context, String message) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Icon(
      Icons.error_outline_rounded,
      size: 50,
      color: HexColor(ColorCode.primaryColor),
    ),
    const SizedBox(height: 10),
    AppText(
        text: message,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black)
  ]);
}
