import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remburshiment_app/constant/color_code.dart';
import 'package:remburshiment_app/constant/image_constant.dart';
import 'package:remburshiment_app/constant/string_constant.dart';
import 'package:remburshiment_app/widgets/app_text.dart';

class FileUploadWidget extends StatefulWidget {
  const FileUploadWidget({super.key});

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: StringConstant.fileUploadText,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: _dashContainerWidget(context, ImageConstant.uploadIcon,
                      StringConstant.uploadBillText),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: AppText(
                  text: StringConstant.orText.toUpperCase(),
                  color: HexColor(ColorCode.greyColor),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: _dashContainerWidget(context, ImageConstant.scanIcon,
                      StringConstant.scanUploadText),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget _dashContainerWidget(BuildContext context, String image, String title) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    height: 114,
    child: DottedBorder(
        dashPattern: const [5, 5],
        strokeWidth: 1,
        borderType: BorderType.RRect,
        radius: const Radius.circular(5),
        color: HexColor(ColorCode.primaryColor),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: 41,
                height: 41,
              ),
              const SizedBox(
                height: 4,
              ),
              AppText(
                text: title,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: HexColor(ColorCode.primaryColor),
              )
            ],
          ),
        )),
  );
}
