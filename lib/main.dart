import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_version2/screens/home_screen/home_screen_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: Routes.selectRole,
      // getPages: AppPages.routes,
      home: HomeScreenView(),
    );
  }
}
