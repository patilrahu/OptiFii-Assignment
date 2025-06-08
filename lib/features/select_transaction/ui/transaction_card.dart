import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remburshiment_app/constant/color_code.dart';
import 'package:remburshiment_app/constant/image_constant.dart';
import 'package:remburshiment_app/constant/string_constant.dart';
import 'package:remburshiment_app/helper/app_date_helper.dart';
import 'package:remburshiment_app/widgets/app_card.dart';
import 'package:remburshiment_app/widgets/app_radio_button.dart';
import 'package:remburshiment_app/widgets/app_text.dart';

class TransactionCard extends StatefulWidget {
  final Map<String, dynamic> data;
  bool isSelected = false;
  final VoidCallback onTap;
  TransactionCard(
      {super.key,
      required this.data,
      required this.isSelected,
      required this.onTap});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return appCard(
      context,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  widget.data['selectedCategory'] == 'Fuel'
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
                      text: widget.data['wallet'],
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    AppText(
                      text: formatDate(widget.data['selectedDate']),
                      fontSize: 14,
                      color: HexColor(ColorCode.lightGreyColor),
                      fontWeight: FontWeight.w400,
                    ),
                    Container(
                      height: 32,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(bottom: 20, top: 14),
                      padding: const EdgeInsets.only(left: 11, right: 11),
                      decoration: BoxDecoration(
                          color: HexColor(ColorCode.walletColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: AppText(
                        text:
                            '${StringConstant.paidFromWallet} ${widget.data['wallet']} wallet',
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 16, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppRadioButton(
                  isSelected: widget.isSelected,
                  onTap: widget.onTap,
                ),
                const SizedBox(
                  height: 59,
                ),
                AppText(
                  text: "+ ${widget.data['addAmount']}",
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
