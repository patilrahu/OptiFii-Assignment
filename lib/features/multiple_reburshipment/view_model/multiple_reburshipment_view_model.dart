import 'dart:convert';

import 'package:get/get.dart';
import 'package:remburshiment_app/utils/app_logger.dart';
import 'package:remburshiment_app/utils/app_shared_preference_helper.dart';

class MultipleReburshipmentViewModel extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Map<String, dynamic>> reburshipmentList = <Map<String, dynamic>>[].obs;
  Future<void> getReburshipmentList() async {
    isLoading.value = true;
    try {
      final data = await SharedPreferenceHelper.getValue(
        SharedPreferenceHelper.storeReumburshipment,
      );
      await Future.delayed(const Duration(seconds: 2));

      if (data != null) {
        final decodedList = jsonDecode(data);
        reburshipmentList.value = List<Map<String, dynamic>>.from(decodedList);
        isLoading.value = false;
      } else {
        reburshipmentList.clear();
        isLoading.value = false;
      }
    } catch (e) {
      AppLogger.error('Error fetching list: $e');
      reburshipmentList.clear();
      isLoading.value = false;
    }
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
}
