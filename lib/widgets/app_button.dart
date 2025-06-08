import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remburshiment_app/constant/color_code.dart';
import 'package:remburshiment_app/widgets/app_loader.dart';
import 'package:remburshiment_app/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final bool isLoading;
  final bool isDisable;

  const AppButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.color,
      this.textColor,
      this.borderRadius = 10,
      this.padding,
      this.isLoading = false,
      this.isDisable = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisable ? null : onPressed,
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            color: HexColor(ColorCode.primaryColor)),
        width: MediaQuery.of(context).size.width,
        height: 48,
        child: isLoading
            ? AppLoader(
                size: 25.0,
                color: Colors.white,
              )
            : AppText(
                text: text,
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
      ),
    );
  }
}
