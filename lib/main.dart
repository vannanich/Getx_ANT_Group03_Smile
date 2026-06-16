import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/book_appointment/book_appointment_view.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/d_homescreen/d_homescreen_view.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  await GetStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final token = GetStorage().read('token');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: token != null ? AppRoutes.homescreen : AppRoutes.login,
      // initialRoute: AppRoutes.dHomescreen,
      getPages: AppPages.pages,
    );
  }
}