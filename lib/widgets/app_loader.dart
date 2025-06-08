import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  Color? color;
  double? size;
  AppLoader({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: color ?? Colors.white,
      ),
    );
  }
}
