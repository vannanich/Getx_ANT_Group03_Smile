// lib/app/auth/signup_screen/signup_screen_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';

class SignUpScreenController extends GetxController {
  // ── Text controllers ──────────────────────────────────────────────────────
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // ── Observables ───────────────────────────────────────────────────────────
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isLoading = false.obs;

  // ── Validation errors ─────────────────────────────────────────────────────
  final usernameError = ''.obs;
  final passwordError = ''.obs;
  final confirmPasswordError = ''.obs;

  // ── Toggles ───────────────────────────────────────────────────────────────
  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  void toggleConfirmPasswordVisibility() =>
      isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;

  // ── Validation ────────────────────────────────────────────────────────────
  bool _validate() {
    bool valid = true;

    final username = usernameController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    // Username
    if (username.isEmpty) {
      usernameError.value = 'Username is required';
      valid = false;
    } else if (username.length < 3) {
      usernameError.value = 'Username must be at least 3 characters';
      valid = false;
    } else {
      usernameError.value = '';
    }

    // Password
    if (password.isEmpty) {
      passwordError.value = 'Password is required';
      valid = false;
    } else if (password.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      valid = false;
    } else {
      passwordError.value = '';
    }

    // Confirm password
    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = 'Please confirm your password';
      valid = false;
    } else if (confirmPassword != password) {
      confirmPasswordError.value = 'Passwords do not match';
      valid = false;
    } else {
      confirmPasswordError.value = '';
    }

    return valid;
  }

  // ── Actions ───────────────────────────────────────────────────────────────
  Future<void> signUp() async {
    if (!_validate()) return;

    isLoading.value = true;
    try {
      // TODO: hook up your real sign-up logic here
      await Future.delayed(const Duration(seconds: 2));
      Get.toNamed(AppRoutes.homescreen);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onSignIn() => Get.toNamed(AppRoutes.login);

  void signUpWithGoogle() {
    // TODO: hook up Google sign-up
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}