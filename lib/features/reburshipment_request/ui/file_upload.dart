import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remburshiment_app/constant/color_code.dart';
import 'package:remburshiment_app/constant/image_constant.dart';
import 'package:remburshiment_app/constant/string_constant.dart';
import 'package:remburshiment_app/features/reburshipment_request/ui/camera_screen.dart';
import 'package:remburshiment_app/features/reburshipment_request/view_model/reburshiment_request_view_model.dart';
import 'package:remburshiment_app/helper/permission_helper.dart';
import 'package:remburshiment_app/helper/upload_bill.dart';
import 'package:remburshiment_app/utils/app_logger.dart';
import 'package:remburshiment_app/utils/app_navigation.dart';
import 'package:remburshiment_app/widgets/app_text.dart';

class FileUploadWidget extends StatefulWidget {
  ReburshimentRequestViewModel reburshimentRequestViewModel;
  final void Function(Map<String, dynamic>) onBillProcessed;
  FileUploadWidget(
      {super.key,
      required this.reburshimentRequestViewModel,
      required this.onBillProcessed});

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  Future<void> _uploadAndProcessBill() async {
    widget.reburshimentRequestViewModel.isFileUploadLoading.value = true;
    final file = await UploadBill.pickBillImage();
    if (file != null) {
      String fetchText = await UploadBill.processBillImage(file);
      var data = await UploadBill.getDataUsingAi(fetchText);
      widget.onBillProcessed(json.decode(_removeString(data)));
      widget.reburshimentRequestViewModel.isFileUploadLoading.value = false;
    } else {
      widget.reburshimentRequestViewModel.isFileUploadLoading.value = false;
      AppLogger.error("No image selected.");
    }
  }

  String _removeString(String text) {
    final cleaned = text
        .replaceAll(RegExp(r'I/flutter.*?:\s*'), '')
        .replaceAll('```json', '')
        .replaceAll('```', '')
        .replaceAll('-------->', '')
        .trim();
    return cleaned;
  }

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
                  onTap: () async {
                    _uploadAndProcessBill();
                  },
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
                  onTap: () {
                    NavigationHelper.push(context, CameraScreen(
                      image: (selectedImage) async {
                        widget.reburshimentRequestViewModel.isFileUploadLoading
                            .value = true;

                        if (selectedImage != null) {
                          String fetchText =
                              await UploadBill.processBillImage(selectedImage);
                          var data = await UploadBill.getDataUsingAi(fetchText);
                          widget.onBillProcessed(
                              json.decode(_removeString(data)));
                          widget.reburshimentRequestViewModel
                              .isFileUploadLoading.value = false;
                        } else {
                          widget.reburshimentRequestViewModel
                              .isFileUploadLoading.value = false;
                          AppLogger.error("No image selected.");
                        }
                      },
                    ));
                  },
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
