import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remburshiment_app/constant/color_code.dart';
import 'package:remburshiment_app/constant/string_constant.dart';
import 'package:remburshiment_app/features/reburshipment_request/ui/reburshipment_request.dart';
import 'package:remburshiment_app/features/select_transaction/ui/transaction_card.dart';
import 'package:remburshiment_app/features/select_transaction/view_model/select_transaction.dart';
import 'package:remburshiment_app/utils/app_navigation.dart';
import 'package:remburshiment_app/utils/app_toast.dart';
import 'package:remburshiment_app/widgets/app_background.dart';
import 'package:remburshiment_app/widgets/app_button.dart';
import 'package:remburshiment_app/widgets/app_loader.dart';
import 'package:remburshiment_app/widgets/app_no_data_widget.dart';
import 'package:remburshiment_app/widgets/app_text.dart';

class SelectTransaction extends StatefulWidget {
  const SelectTransaction({super.key});

  @override
  State<SelectTransaction> createState() => _SelectTransactionState();
}

class _SelectTransactionState extends State<SelectTransaction> {
  final _selectTransactionController = Get.put(SelectTransactionViewModel());
  int? selectedIndex;
  @override
  void initState() {
    super.initState();
    getTransactionList();
  }

  void getTransactionList() async {
    await _selectTransactionController.getReburshipmentList();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
        child: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: StringConstant.selectFromTransaction,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          Obx(
            () => Visibility(
              visible: !_selectTransactionController.isLoading.value,
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
                visible:
                    _selectTransactionController.reburshipmentList.isNotEmpty,
                replacement: Container(
                    margin: const EdgeInsets.only(top: 40),
                    alignment: Alignment.center,
                    child: noDataWidget(context, StringConstant.noDataText)),
                child: Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 20),
                    itemBuilder: (context, index) {
                      var transactionData =
                          _selectTransactionController.reburshipmentList[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: TransactionCard(
                            isSelected: index == selectedIndex,
                            data: transactionData,
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    itemCount:
                        _selectTransactionController.reburshipmentList.length,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AppButton(
                text: StringConstant.nextBtnText,
                onPressed: () {
                  if (selectedIndex != null) {
                    NavigationHelper.push(
                        context,
                        ReburshipmentRequest(
                          isEditDetailRequest: true,
                          data: _selectTransactionController
                              .reburshipmentList[selectedIndex!],
                        ));
                  } else {
                    AppToast.showErrorToast(
                        context, StringConstant.selectTransactionErrorText);
                  }
                },
              ),
            ),
          )
        ],
      ),
    ));
  }
}
