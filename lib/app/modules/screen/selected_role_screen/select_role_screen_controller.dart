import 'package:get/get.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';

class SelectRoleScreenController extends GetxController {
  final selectedRole = RxnString();

  bool get hasSelectedRole => selectedRole.value != null;
  bool get isDoctor => selectedRole.value == 'doctor';
  bool get isUser => selectedRole.value == 'user';

  void selectRole(String role) {
    selectedRole.value = role;
  }

  void onContinue() {
    if (!hasSelectedRole) return;

    if (isDoctor) {
      Get.toNamed(AppRoutes.homescreen);
    } else {
      Get.toNamed(AppRoutes.moodSelection);
    }
  }
}