
import 'package:flutter_application_1/app/auth/sign_up_screen/sign_up_screen_controller.dart';
import 'package:get/get.dart';

class SignUpScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpScreenController>(() => SignUpScreenController());
  }
}