import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: AppRoutes.videoscreen,
      initialRoute: AppRoutes.login,
      getPages: AppPages.pages,
    );
  }
}
