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
<<<<<<< HEAD
      initialRoute: AppRoutes.profilescreen,
=======
      initialRoute: AppRoutes.dTodayAppoitment,
>>>>>>> 4e95e2c4c35ec773b4bde8cc2dafb86321342c75
      getPages: AppPages.pages,
    );
  }
}
