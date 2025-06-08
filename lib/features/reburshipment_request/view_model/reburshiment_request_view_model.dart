import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:remburshiment_app/utils/app_shared_preference_helper.dart';

class ReburshimentRequestViewModel extends GetxController {
  final walletController = TextEditingController();
  final addAmountController = TextEditingController();
  final purposeController = TextEditingController();
  final mearchantController = TextEditingController();
  final remarkController = TextEditingController();
  RxnString selectedDate = RxnString();
  RxnString selectedCategory = RxnString();
  RxBool isLoading = false.obs;

  Future<List<dynamic>?> getReburshipmentList() async {
    final raw = await SharedPreferenceHelper.getValue(
      SharedPreferenceHelper.storeReumburshipment,
    );

    if (raw != null && raw is String) {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return List<Map<String, dynamic>>.from(decoded);
      }
    }
    return [];
  }

  Future<List<dynamic>?> getReburshipmentReportList() async {
    final raw = await SharedPreferenceHelper.getValue(
      SharedPreferenceHelper.reportReumburshipment,
    );

    if (raw != null && raw is String) {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return List<Map<String, dynamic>>.from(decoded);
      }
    }
    return [];
  }

  @override
  void onClose() {
    walletController.dispose();
    addAmountController.dispose();
    purposeController.dispose();
    mearchantController.dispose();
    remarkController.dispose();
    super.onClose();
  }
}
