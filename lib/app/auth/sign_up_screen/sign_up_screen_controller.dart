import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';

class SignUpScreenController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isLoading = false.obs;

  final usernameError = ''.obs;
  final emailError = ''.obs;
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
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    // ── Username ──────────────────────────────────────────────────────────────
    if (username.isEmpty) {
      usernameError.value = 'Username is required';
      valid = false;
    } else if (username.length < 3) {
      usernameError.value = 'Username must be at least 3 characters';
      valid = false;
    } else {
      usernameError.value = '';
    }

    // ── Email ─────────────────────────────────────────────────────────────────
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');
    if (email.isEmpty) {
      emailError.value = 'Email is required';
      valid = false;
    } else if (!emailRegex.hasMatch(email)) {
      emailError.value = 'Enter a valid email (e.g. user@example.com)';
      valid = false;
    } else {
      emailError.value = '';
    }

    // ── Password ──────────────────────────────────────────────────────────────
    // Rules:
    //   • At least 8 characters
    //   • At least one letter  (a-z or A-Z)
    //   • At least one number  (0-9)
    //   • At least one symbol  (any non-alphanumeric character)
    //   • No spaces
    final hasMinLength = password.length >= 8;
    final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(password);
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);
    final hasSymbol = RegExp(r'[^a-zA-Z0-9]').hasMatch(password);
    final hasNoSpace = !password.contains(' ');

    if (password.isEmpty) {
      passwordError.value = 'Password is required';
      valid = false;
    } else if (!hasNoSpace) {
      passwordError.value = 'Password must not contain spaces';
      valid = false;
    } else if (!hasMinLength) {
      passwordError.value = 'Password must be at least 8 characters';
      valid = false;
    } else if (!hasLetter) {
      passwordError.value = 'Password must include at least one letter';
      valid = false;
    } else if (!hasNumber) {
      passwordError.value = 'Password must include at least one number';
      valid = false;
    } else if (!hasSymbol) {
      passwordError.value =
          'Password must include at least one symbol (e.g. @, #, !)';
      valid = false;
    } else {
      passwordError.value = '';
    }

    // ── Confirm Password ──────────────────────────────────────────────────────
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
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}