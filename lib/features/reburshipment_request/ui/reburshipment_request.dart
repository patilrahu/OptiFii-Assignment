import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remburshiment_app/constant/color_code.dart';
import 'package:remburshiment_app/constant/image_constant.dart';
import 'package:remburshiment_app/constant/string_constant.dart';
import 'package:remburshiment_app/features/multiple_reburshipment/ui/multiple_reburshipment.dart';
import 'package:remburshiment_app/features/reburshipment_request/ui/file_upload.dart';
import 'package:remburshiment_app/features/reburshipment_request/view_model/reburshiment_request_view_model.dart';
import 'package:remburshiment_app/features/report_detail/ui/report_detail.dart';
import 'package:remburshiment_app/features/select_transaction/ui/select_transaction.dart';
import 'package:remburshiment_app/utils/app_logger.dart';
import 'package:remburshiment_app/utils/app_navigation.dart';
import 'package:remburshiment_app/utils/app_pop_up.dart';
import 'package:remburshiment_app/utils/app_shared_preference_helper.dart';
import 'package:remburshiment_app/utils/app_toast.dart';
import 'package:remburshiment_app/widgets/app_background.dart';
import 'package:remburshiment_app/widgets/app_button.dart';
import 'package:remburshiment_app/widgets/app_card.dart';
import 'package:remburshiment_app/widgets/app_date_picker.dart';
import 'package:remburshiment_app/widgets/app_dropdown.dart';
import 'package:remburshiment_app/widgets/app_text.dart';
import 'package:remburshiment_app/widgets/app_textfield.dart';

class ReburshipmentRequest extends StatefulWidget {
  bool? isEditDetailRequest = false;
  final Map<String, dynamic>? data;
  ReburshipmentRequest(
      {super.key, this.isEditDetailRequest = false, this.data});

  @override
  State<ReburshipmentRequest> createState() => _ReburshipmentRequestState();
}

class _ReburshipmentRequestState extends State<ReburshipmentRequest> {
  final _controller = Get.put(ReburshimentRequestViewModel());
  @override
  void initState() {
    super.initState();
    if (widget.isEditDetailRequest ?? false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setData();
      });
    }
  }

  void setData() {
    final data = widget.data;
    if (data != null) {
      setState(() {
        _controller.walletController.text = data['wallet'] ?? '';
        _controller.addAmountController.text = data['addAmount'] ?? '';
        _controller.purposeController.text = data['purpose'] ?? '';
        _controller.mearchantController.text = data['mearchant'] ?? '';
        _controller.remarkController.text = data['remark'] ?? '';
        _controller.selectedCategory.value = data['selectedCategory'] ?? '';
        _controller.selectedDate.value = data['selectedDate'] ?? '';
      });
    }
  }

  void _clearAllField() {
    _controller.walletController.clear();
    _controller.addAmountController.clear();
    _controller.purposeController.clear();
    _controller.mearchantController.clear();
    _controller.remarkController.clear();
    _controller.selectedCategory.value = '';
    _controller.selectedDate.value = '';
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller.onClose();
  // }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
        child: SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 12),
        child: Column(
          children: [
            Visibility(
              visible: !(widget.isEditDetailRequest ?? false),
              child: GestureDetector(
                onTap: () {
                  NavigationHelper.push(context, const SelectTransaction());
                },
                child: appCard(
                  context,
                  padding: const EdgeInsets.only(left: 26, right: 16),
                  height: 62,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: StringConstant.selectFromTransaction,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: HexColor(ColorCode.primaryColor)),
                        child: Image.asset(ImageConstant.arrowRightIcon),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !(widget.isEditDetailRequest ?? false),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: AppText(
                  text: StringConstant.orText.toUpperCase(),
                  fontSize: 14,
                  color: HexColor(ColorCode.greyColor),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Visibility(
                visible: !(widget.isEditDetailRequest ?? false),
                child: const FileUploadWidget()),
            AppTextfield(
              controller: _controller.walletController,
              fillColor: HexColor(ColorCode.borderColor).withOpacity(0.4),
              hintText: StringConstant.walletText,
            ),
            AppTextfield(
              controller: _controller.addAmountController,
              keyboardType: TextInputType.number,
              prefixIcon: AppText(
                text: StringConstant.currencySymbol,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              hintText: StringConstant.addAmountText,
            ),
            Obx(
              () => AppDropdown(
                  options: StringConstant.selectCategoryOption,
                  onChanged: (value) {
                    setState(() {
                      _controller.selectedCategory.value = value;
                    });
                  },
                  selectedOption: _controller.selectedCategory.value,
                  placeholder: StringConstant.selectCategory),
            ),
            AppTextfield(
              hintText: StringConstant.purPoseText,
              controller: _controller.purposeController,
            ),
            AppTextfield(
              controller: _controller.mearchantController,
              hintText: StringConstant.marchantName,
            ),
            Obx(() => AppDatePicker(
                  hintTextDate: StringConstant.dateText,
                  onDateSelected: (date) {
                    setState(() {
                      _controller.selectedDate.value = date.toString();
                    });
                  },
                  defaultDate: _controller.selectedDate.value,
                )),
            AppTextfield(
              controller: _controller.remarkController,
              maxLines: 4,
              hintText: StringConstant.remarkText,
            ),
            Obx(
              () => AppButton(
                isLoading: _controller.isLoading.value,
                text: (widget.isEditDetailRequest ?? false)
                    ? StringConstant.addToReportText
                    : StringConstant.saveBtnText,
                onPressed: () async {
                  if ((widget.isEditDetailRequest ?? false)) {
                    AppPopUp.showPopUpDialog(context, () async {
                      final data = {
                        "id": widget.data?['id'],
                        "wallet": _controller.walletController.text,
                        "addAmount": _controller.addAmountController.text,
                        "purpose": _controller.purposeController.text,
                        "mearchant": _controller.mearchantController.text,
                        "remark": _controller.remarkController.text,
                        "selectedDate": _controller.selectedDate.value,
                        "selectedCategory": _controller.selectedCategory.value,
                      };
                      final existingList =
                          await _controller.getReburshipmentReportList();
                      final updatedList = existingList != null
                          ? (List<Map<String, dynamic>>.from(existingList)
                            ..add(data))
                          : [data];
                      await SharedPreferenceHelper.save(
                          SharedPreferenceHelper.reportReumburshipment,
                          jsonEncode(updatedList));
                      NavigationHelper.pop(context);
                      NavigationHelper.push(context, const ReportDetail());
                    },
                        StringConstant.addToReportText,
                        AddReportWidget(
                          title: StringConstant.addReportSuccess,
                        ));
                  } else {
                    _controller.isLoading.value = true;
                    if (_controller.addAmountController.text != "" &&
                        _controller.mearchantController.text != '' &&
                        _controller.addAmountController.text != '' &&
                        _controller.purposeController.text != '' &&
                        _controller.walletController.text != '' &&
                        _controller.selectedCategory.value != '' &&
                        _controller.selectedDate.value != '') {
                      final data = {
                        "id": StringConstant.uuid.v4(),
                        "wallet": _controller.walletController.text,
                        "addAmount": _controller.addAmountController.text,
                        "purpose": _controller.purposeController.text,
                        "mearchant": _controller.mearchantController.text,
                        "remark": _controller.remarkController.text,
                        "selectedDate": _controller.selectedDate.value,
                        "selectedCategory": _controller.selectedCategory.value,
                      };

                      try {
                        await Future.delayed(const Duration(seconds: 2));
                        final existingList =
                            await _controller.getReburshipmentList();
                        final updatedList = existingList != null
                            ? (List<Map<String, dynamic>>.from(existingList)
                              ..add(data))
                            : [data];
                        await SharedPreferenceHelper.save(
                            SharedPreferenceHelper.storeReumburshipment,
                            jsonEncode(updatedList));
                        _controller.isLoading.value = false;
                        _clearAllField();
                        // ignore: use_build_context_synchronously
                        NavigationHelper.push(
                            context, const MultipleReburshipment());
                      } catch (e) {
                        AppLogger.error(e.toString());
                        _controller.isLoading.value = false;
                      }
                    } else {
                      _controller.isLoading.value = false;
                      AppToast.showErrorToast(
                          context, StringConstant.formEmptyText);
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class AddReportWidget extends StatefulWidget {
  String? title;
  AddReportWidget({super.key, required this.title});

  @override
  State<AddReportWidget> createState() => _AddReportWidgetState();
}

class _AddReportWidgetState extends State<AddReportWidget> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() => isVisible = !isVisible);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: isVisible ? 0.3 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: isVisible ? 70 : 90,
            width: isVisible ? 70 : 90,
            child: Image.asset(
              ImageConstant.correctIcon,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 25),
        AppText(
          text: widget.title ?? '',
          fontSize: 16,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w500,
        )
      ],
    );
  }
}
