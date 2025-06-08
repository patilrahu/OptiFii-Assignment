import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remburshiment_app/constant/color_code.dart';

class AppRadioButton extends StatefulWidget {
  final bool isSelected;
  final VoidCallback onTap;
  const AppRadioButton(
      {super.key, required this.isSelected, required this.onTap});

  @override
  State<AppRadioButton> createState() => _AppRadioButtonState();
}

class _AppRadioButtonState extends State<AppRadioButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 18,
        width: 18,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: HexColor(ColorCode.primaryColor),
              width: 2,
            )),
        child: widget.isSelected
            ? Center(
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: HexColor(ColorCode.primaryColor),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
