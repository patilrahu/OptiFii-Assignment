import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:remburshiment_app/constant/string_constant.dart';
import 'package:remburshiment_app/features/reburshipment_request/ui/reburshipment_request.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: StringConstant.appFontFamily,
          useMaterial3: true,
        ),
        home: ReburshipmentRequest(),
      ),
    );
  }
}
