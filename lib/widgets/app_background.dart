import 'package:flutter/material.dart';
import 'package:remburshiment_app/constant/string_constant.dart';
import 'package:remburshiment_app/widgets/app_header.dart';

class AppBackground extends StatefulWidget {
  Widget child;
  String? navBarTitle;
  AppBackground({super.key, required this.child, this.navBarTitle});

  @override
  State<AppBackground> createState() => _AppBackgroundState();
}

class _AppBackgroundState extends State<AppBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              appHeader(
                  context,
                  widget.navBarTitle ??
                      StringConstant.reimbursementRequestHeading),
              Expanded(child: widget.child),
            ],
          ),
        ),
      )),
    );
  }
}
