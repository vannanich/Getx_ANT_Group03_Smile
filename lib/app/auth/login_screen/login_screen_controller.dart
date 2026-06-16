import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginScreenController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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

      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailController.text.trim(),
          'password': passwordController.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['token'] != null) {
        GetStorage().write('token', data['token']);
        Get.offAllNamed(AppRoutes.homescreen);
        Get.snackbar('Success', 'Signed in successfully!',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', data['error'] ?? 'Login failed',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Cannot connect to server',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> continueAsGuest() async {
    Get.offAllNamed(AppRoutes.homescreen);
  }

  Future<void> signInWithGoogle() async {}
  Future<void> signInWithFacebook() async {}

  void onForgotPassword() {}

  void onSignUp() {
    Get.toNamed(AppRoutes.signUp);
  }
}