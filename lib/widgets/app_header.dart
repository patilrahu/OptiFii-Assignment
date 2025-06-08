import 'package:flutter/material.dart';
import 'package:remburshiment_app/constant/image_constant.dart';
import 'package:remburshiment_app/utils/app_navigation.dart';
import 'package:remburshiment_app/widgets/app_text.dart';

Widget appHeader(BuildContext context, String? title) {
  return Container(
    // height: 50,
    margin: const EdgeInsets.only(top: 18, left: 16, right: 17),
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            NavigationHelper.pop(context);
          },
          child: Row(
            children: [
              Image.asset(
                ImageConstant.backIcon,
                width: 24,
                height: 24,
              ),
              const SizedBox(
                width: 8,
              ),
              AppText(
                text: title ?? '',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
        Image.asset(
          ImageConstant.bellIcon,
          width: 24,
          height: 24,
        ),
      ],
    ),
  );
}
