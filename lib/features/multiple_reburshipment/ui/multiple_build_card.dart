import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remburshiment_app/constant/color_code.dart';
import 'package:remburshiment_app/constant/image_constant.dart';
import 'package:remburshiment_app/constant/string_constant.dart';
import 'package:remburshiment_app/features/reburshipment_request/ui/reburshipment_request.dart';
import 'package:remburshiment_app/features/report_detail/view_model/report_detail_view_model.dart';
import 'package:remburshiment_app/helper/app_date_helper.dart';
import 'package:remburshiment_app/utils/app_navigation.dart';
import 'package:remburshiment_app/utils/app_shared_preference_helper.dart';
import 'package:remburshiment_app/widgets/app_card.dart';
import 'package:remburshiment_app/widgets/app_text.dart';

class MultipleBuildCard extends StatefulWidget {
  final Map<String, dynamic>? data;
  ReportDetailViewModel? reportDetailViewModel;
  MultipleBuildCard({super.key, this.data, this.reportDetailViewModel});

  @override
  State<MultipleBuildCard> createState() => _MultipleBuildCardState();
}

class _MultipleBuildCardState extends State<MultipleBuildCard> {
  @override
  Widget build(BuildContext context) {
    return appCard(
      context,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      widget.data?['selectedCategory'] == 'Fuel'
                          ? ImageConstant.fuelIcon
                          : ImageConstant.foodIcon,
                      height: 36,
                      width: 36,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: 'Food',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        AppText(
                          text: widget.data != null
                              ? formatDate(widget.data?['selectedDate'])
                              : '',
                          fontSize: 14,
                          color: HexColor(ColorCode.lightGreyColor),
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 11, top: 20),
                  child: AppText(
                    text:
                        "${StringConstant.currencySymbol} ${widget.data?['addAmount']}",
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  height: 32,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 16, top: 16),
                  padding: const EdgeInsets.only(left: 11, right: 11),
                  decoration: BoxDecoration(
                      color: HexColor(ColorCode.walletColor),
                      borderRadius: BorderRadius.circular(5)),
                  child: AppText(
                    text:
                        '${StringConstant.paidFromWallet} ${widget.data?['wallet']} wallet',
                    fontSize: 14,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          HexColor(ColorCode.gradientColorPrimary),
                          HexColor(ColorCode.gradientColorSecondary)
                        ],
                      ).createShader(
                        const Rect.fromLTWH(0, 0, 300, 0),
                      ),
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 28,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      color: HexColor(ColorCode.lightYellowColor),
                      borderRadius: BorderRadius.circular(4)),
                  child: AppText(
                    text: StringConstant.savedText,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: HexColor(ColorCode.yellowColor),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        NavigationHelper.push(
                            context,
                            ReburshipmentRequest(
                              isEditDetailRequest: true,
                              data: widget.data,
                            ));
                      },
                      child: Image.asset(
                        ImageConstant.editIcon,
                        height: 24,
                        width: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        widget.reportDetailViewModel?.reportReburshipmentList
                            .remove(widget.data);
                        await SharedPreferenceHelper.save(
                          SharedPreferenceHelper.reportReumburshipment,
                          jsonEncode(widget
                              .reportDetailViewModel?.reportReburshipmentList),
                        );
                      },
                      child: Image.asset(
                        ImageConstant.deleteIcon,
                        height: 24,
                        width: 24,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
