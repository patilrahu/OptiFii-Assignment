import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remburshiment_app/constant/color_code.dart';
import 'package:remburshiment_app/constant/image_constant.dart';
import 'package:remburshiment_app/constant/string_constant.dart';
import 'package:remburshiment_app/features/multiple_reburshipment/ui/multiple_build_card.dart';
import 'package:remburshiment_app/features/reburshipment_request/ui/reburshipment_request.dart';
import 'package:remburshiment_app/features/report_detail/view_model/report_detail_view_model.dart';
import 'package:remburshiment_app/utils/app_navigation.dart';
import 'package:remburshiment_app/utils/app_pop_up.dart';
import 'package:remburshiment_app/widgets/app_background.dart';
import 'package:remburshiment_app/widgets/app_button.dart';
import 'package:remburshiment_app/widgets/app_loader.dart';
import 'package:remburshiment_app/widgets/app_no_data_widget.dart';
import 'package:remburshiment_app/widgets/app_text.dart';

class ReportDetail extends StatefulWidget {
  const ReportDetail({super.key});

  @override
  State<ReportDetail> createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  final _selectReportRebushipmentController = Get.put(ReportDetailViewModel());
  @override
  void initState() {
    super.initState();
    getReportDetailList();
  }

  void getReportDetailList() async {
    await _selectReportRebushipmentController.getReportReburshipmentList();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Divider(
            color: HexColor(ColorCode.lineColor),
            thickness: 2,
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 16, top: 20, bottom: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: 'Reimbursement report May-2025',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              AppText(
                text: 'Last update : 20-05-2025 | 4.20pm',
                fontSize: 14,
                color: HexColor(ColorCode.greyColor),
                fontWeight: FontWeight.w400,
              ),
              Container(
                height: 42,
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: HexColor(ColorCode.lightYellowColor),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(ImageConstant.bookImage),
                        const SizedBox(
                          width: 5,
                        ),
                        AppText(
                          text: 'Report Status',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    AppText(
                      text: StringConstant.savedText,
                      fontSize: 14,
                      color: HexColor(ColorCode.yellowColor),
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
            child:
                ListView(padding: const EdgeInsets.only(bottom: 20), children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: HexColor(ColorCode.lineColor)),
            ),
            child: Column(
              children: [
                Obx(
                  () => Visibility(
                    visible: !(_selectReportRebushipmentController
                        .isReportSubmit.value),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: StringConstant.expenseListText,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          GestureDetector(
                            onTap: () {
                              // NavigationHelper.push(
                              //     context,
                              //     ReburshipmentRequest(
                              //       isEditDetailRequest: false,
                              //     ));
                            },
                            child: Row(
                              children: [
                                Image.asset(ImageConstant.addIcon),
                                AppText(
                                  text: StringConstant.addExpenseText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: HexColor(ColorCode.primaryColor),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: HexColor(ColorCode.lineColor),
                  thickness: 2,
                ),
                Obx(() => Visibility(
                    visible:
                        !_selectReportRebushipmentController.isLoading.value,
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
                        visible: _selectReportRebushipmentController
                            .reportReburshipmentList.isNotEmpty,
                        replacement: Container(
                            margin: const EdgeInsets.only(top: 40),
                            alignment: Alignment.center,
                            child: noDataWidget(
                                context, StringConstant.noDataText)),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _selectReportRebushipmentController
                              .reportReburshipmentList.length,
                          padding: const EdgeInsets.only(top: 20),
                          itemBuilder: (context, index) {
                            var reportData = _selectReportRebushipmentController
                                .reportReburshipmentList[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 20, left: 16, right: 16),
                              child: MultipleBuildCard(
                                data: reportData,
                                reportDetailViewModel:
                                    _selectReportRebushipmentController,
                              ),
                            );
                          },
                        )))),
              ],
            ),
          ),
        ])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppButton(
            text: StringConstant.submitReport,
            onPressed: () {
              AppPopUp.showPopUpDialog(context, () async {
                _selectReportRebushipmentController.isReportSubmit.value = true;
                NavigationHelper.pop(context);
              },
                  StringConstant.viewReport,
                  AddReportWidget(
                    title: StringConstant.reportSuccessText,
                  ));
            },
          ),
        )
      ],
    ));
  }
}
