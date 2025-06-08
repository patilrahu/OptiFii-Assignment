import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remburshiment_app/constant/color_code.dart';
import 'package:remburshiment_app/constant/string_constant.dart';
import 'package:remburshiment_app/features/multiple_reburshipment/ui/multiple_build_card.dart';
import 'package:remburshiment_app/features/report_detail/ui/report_detail.dart';
import 'package:remburshiment_app/utils/app_navigation.dart';
import 'package:remburshiment_app/widgets/app_background.dart';
import 'package:remburshiment_app/widgets/app_button.dart';
import 'package:remburshiment_app/widgets/app_text.dart';

class MultipleReburshipment extends StatefulWidget {
  const MultipleReburshipment({super.key});

  @override
  State<MultipleReburshipment> createState() => _MultipleReburshipmentState();
}

class _MultipleReburshipmentState extends State<MultipleReburshipment> {
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: '4 bills uploaded',
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
                    text: '${StringConstant.currencySymbol} 2000',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 20),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20, left: 16, right: 16),
                child: MultipleBuildCard(),
              );
            },
            itemCount: 10,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppButton(
            text: StringConstant.addToReportText,
            onPressed: () {
              // AppPopUp.showPopUpDialog(
              //     context, () {}, StringConstant.addToReportText, Container());
              NavigationHelper.push(context, const ReportDetail());
            },
          ),
        )
      ],
    ));
  }
}
