import 'package:flutter_application_1/app/auth/login_screen/login_screen_controller.dart';
import 'package:get/get.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginScreenController>(
      () => LoginScreenController(),
    );
  }
}