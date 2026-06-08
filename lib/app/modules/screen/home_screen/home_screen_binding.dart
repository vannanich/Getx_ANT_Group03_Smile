import 'package:flutter_application_1/app/modules/screen/home_screen/home_screen_controller.dart';
import 'package:get/get.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
  }
}