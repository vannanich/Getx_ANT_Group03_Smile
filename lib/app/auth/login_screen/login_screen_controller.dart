import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  // Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable states
  final isPasswordVisible = false.obs;
  final isLoading = false.obs;
  final emailError = ''.obs;
  final passwordError = ''.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  bool _validateInputs() {
    bool isValid = true;

    // Validate email
    final email = emailController.text.trim();
    if (email.isEmpty) {
      emailError.value = 'Email is required';
      isValid = false;
    } else if (!GetUtils.isEmail(email)) {
      emailError.value = 'Enter a valid email address';
      isValid = false;
    } else {
      emailError.value = '';
    }

    // Validate password
    final password = passwordController.text;
    if (password.isEmpty) {
      passwordError.value = 'Password is required';
      isValid = false;
    } else if (password.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      isValid = false;
    } else {
      passwordError.value = '';
    }

    return isValid;
  }

  Future<void> signIn() async {
    if (!_validateInputs()) return;

    try {
      isLoading.value = true;

      // TODO: Replace with your actual sign-in logic / API call
      await Future.delayed(const Duration(seconds: 2));

      Get.offAllNamed(AppRoutes.homescreen);

      Get.snackbar(
        'Success',
        'Signed in successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> continueAsGuest() async {
    // TODO: Navigate to home as guest
    // Get.offAllNamed(Routes.HOME);
    Get.snackbar(
      'Guest Mode',
      'Continuing as guest...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF6A30DE),
      colorText: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      // TODO: Implement Google Sign-In
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      Get.snackbar(
        'Error',
        'Google sign-in failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      isLoading.value = true;
      // TODO: Implement Facebook Sign-In
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      Get.snackbar(
        'Error',
        'Facebook sign-in failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onForgotPassword() {
    // TODO: Navigate to forgot password screen
    // Get.toNamed(Routes.FORGOT_PASSWORD);
  }

  void onSignUp() {
    // TODO: Navigate to sign up screen
    // Get.toNamed(Routes.SIGN_UP);
  }
}