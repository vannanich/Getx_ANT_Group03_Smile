import 'package:get/get.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';

class SelectRoleScreenController extends GetxController {
  // ── State ────────────────────────────────────────────────────────────────
  final selectedRole = RxnString();

  // ── Computed ─────────────────────────────────────────────────────────────
  bool get hasSelectedRole => selectedRole.value != null;
  bool get isDoctor => selectedRole.value == 'doctor';
  bool get isUser => selectedRole.value == 'user';

  // ── Actions ──────────────────────────────────────────────────────────────
  void selectRole(String role) => selectedRole.value = role;

  void onContinue() {
    if (!hasSelectedRole) return;
    Get.toNamed(isDoctor ? AppRoutes.scanId : AppRoutes.moodSelection);
  }
}