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
<<<<<<< Updated upstream
      // initialRoute: Routes.selectRole,
      // getPages: AppPages.routes,
      home: HomeScreenView(),
    );
=======
      initialRoute: AppRoutes.homescreen,
      getPages: AppPages.pages,
      themeMode: themeController.isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    ));
>>>>>>> Stashed changes
  }
}
