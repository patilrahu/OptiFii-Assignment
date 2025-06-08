import 'dart:convert';

import 'package:get/get.dart';
import 'package:remburshiment_app/utils/app_logger.dart';
import 'package:remburshiment_app/utils/app_shared_preference_helper.dart';

class ReportDetailViewModel extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Map<String, dynamic>> reportReburshipmentList =
      <Map<String, dynamic>>[].obs;
  RxBool isReportSubmit = false.obs;
  Future<void> getReportReburshipmentList() async {
    isLoading.value = true;
    try {
      final data = await SharedPreferenceHelper.getValue(
        SharedPreferenceHelper.reportReumburshipment,
      );
      await Future.delayed(const Duration(seconds: 2));

      if (data != null) {
        final decodedList = jsonDecode(data);
        reportReburshipmentList.value =
            List<Map<String, dynamic>>.from(decodedList);
        isLoading.value = false;
      } else {
        reportReburshipmentList.clear();
        isLoading.value = false;
      }
    } catch (e) {
      AppLogger.error('Error fetching list: $e');
      reportReburshipmentList.clear();
      isLoading.value = false;
    }
  }
}
