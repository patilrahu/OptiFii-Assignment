import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remburshiment_app/constant/color_code.dart';
import 'package:remburshiment_app/constant/string_constant.dart';
import 'package:remburshiment_app/features/multiple_reburshipment/ui/multiple_build_card.dart';
import 'package:remburshiment_app/features/multiple_reburshipment/view_model/multiple_reburshipment_view_model.dart';
import 'package:remburshiment_app/features/reburshipment_request/ui/reburshipment_request.dart';
import 'package:remburshiment_app/features/report_detail/ui/report_detail.dart';
import 'package:remburshiment_app/utils/app_navigation.dart';
import 'package:remburshiment_app/utils/app_pop_up.dart';
import 'package:remburshiment_app/utils/app_shared_preference_helper.dart';
import 'package:remburshiment_app/widgets/app_background.dart';
import 'package:remburshiment_app/widgets/app_button.dart';
import 'package:remburshiment_app/widgets/app_loader.dart';
import 'package:remburshiment_app/widgets/app_no_data_widget.dart';
import 'package:remburshiment_app/widgets/app_text.dart';

class MultipleReburshipment extends StatefulWidget {
  const MultipleReburshipment({super.key});

  @override
  State<MultipleReburshipment> createState() => _MultipleReburshipmentState();
}

class _MultipleReburshipmentState extends State<MultipleReburshipment> {
  final _multipleReburshipmentController =
      Get.put(MultipleReburshipmentViewModel());
  @override
  void initState() {
    super.initState();
    getTransactionList();
  }

  void getTransactionList() async {
    await _multipleReburshipmentController.getReburshipmentList();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Divider(
            color: HexColor(ColorCode.lineColor),
            thickness: 2,
          ),
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text:
                      '${_multipleReburshipmentController.reburshipmentList.length} bills uploaded',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                Row(
                  children: [
                    AppText(
                      text: 'Total Amount - ',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    AppText(
                      text:
                          '${StringConstant.currencySymbol} ${getTotalAmount()}',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Obx(() => Visibility(
            visible: !_multipleReburshipmentController.isLoading.value,
            replacement: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: AppLoader(
                  size: 30,
                  color: HexColor(ColorCode.primaryColor),
                ),
              ),
            ),
            child: Visibility(
                visible: _multipleReburshipmentController
                    .reburshipmentList.isNotEmpty,
                replacement: Container(
                    margin: const EdgeInsets.only(top: 40),
                    alignment: Alignment.center,
                    child: noDataWidget(context, StringConstant.noDataText)),
                child: Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 20),
                    itemBuilder: (context, index) {
                      var data = _multipleReburshipmentController
                          .reburshipmentList[index];
                      return Padding(
                        padding:
                            EdgeInsets.only(bottom: 20, left: 16, right: 16),
                        child: MultipleBuildCard(
                          data: data,
                          multipleReburshipmentViewModel:
                              _multipleReburshipmentController,
                        ),
                      );
                    },
                    itemCount: _multipleReburshipmentController
                        .reburshipmentList.length,
                  ),
                )))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppButton(
            text: StringConstant.addToReportText,
            onPressed: () {
              if (_multipleReburshipmentController
                  .reburshipmentList.isNotEmpty) {
                AppPopUp.showPopUpDialog(context, () async {
                  final existingList = await _multipleReburshipmentController
                      .getReburshipmentReportList();
                  final updatedList = existingList != null
                      ? (List<Map<String, dynamic>>.from(existingList)
                        ..addAll(
                            _multipleReburshipmentController.reburshipmentList))
                      : _multipleReburshipmentController.reburshipmentList;
                  await SharedPreferenceHelper.save(
                      SharedPreferenceHelper.reportReumburshipment,
                      jsonEncode(updatedList));
                  NavigationHelper.pop(context);
                  NavigationHelper.pushReplacement(
                      context, const ReportDetail());
                },
                    StringConstant.addToReportText,
                    AddReportWidget(
                      title: StringConstant.addReportSuccess,
                    ));
              }
            },
          ),
        )
      ],
    ));
  }

  double getTotalAmount() {
    return _multipleReburshipmentController.reburshipmentList.fold(0.0,
        (total, item) {
      double amount = 0.0;
      if (item['addAmount'] != null) {
        amount = double.tryParse(item['addAmount'].toString()) ?? 0.0;
      }
      return total + amount;
    });
  }
}
