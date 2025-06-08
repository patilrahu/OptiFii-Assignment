import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remburshiment_app/constant/color_code.dart';

Widget appCard(BuildContext context, Widget child,
    {double? height, EdgeInsets? padding}) {
  return Container(
    padding: padding,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(color: HexColor(ColorCode.borderColor), width: 1)),
    height: height,
    child: child,
  );
}
