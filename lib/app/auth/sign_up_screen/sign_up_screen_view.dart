import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

part 'sign_up_screen_binding.dart';
part 'sign_up_screen_controller.dart';

class SignUpScreenView extends GetView<SignUpScreenViewController> {
  const SignUpScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F0FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEDE0FF),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/logo.png',
                      width: 90,
                      height: 90,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 36),
              Row(
                children: [
                  Text("Sign",
                      style: GoogleFonts.balsamiqSans(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff5B13EC))),
                  const SizedBox(width: 5),
                  Text("Up",
                      style: GoogleFonts.balsamiqSans(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
              const SizedBox(height: 4),
              Text('Sign up your account',
                  style: GoogleFonts.balsamiqSans(
                      fontSize: 15, color: Colors.grey)),
              const SizedBox(height: 24),

              // --- Text Fields connected to controllers ---
              _buildTextField(
                hint: 'Username',
                icon: Icons.person_outline,
                controller: controller.usernameCtrl,
              ),
              const SizedBox(height: 14),
              _buildTextField(
                hint: 'Email',
                icon: Icons.email_outlined,
                controller: controller.emailCtrl,
              ),
              const SizedBox(height: 14),
              Obx(() => _buildTextField(
                hint: 'Password',
                icon: Icons.lock_outline,
                controller: controller.passwordCtrl,
                obscure: controller.obscurePassword.value,
                onToggle: () => controller.obscurePassword.toggle(),
              )),
              const SizedBox(height: 14),
              Obx(() => _buildTextField(
                hint: 'Confirm Password',
                icon: Icons.lock_outline,
                controller: controller.confirmPasswordCtrl,
                obscure: controller.obscureConfirm.value,
                onToggle: () => controller.obscureConfirm.toggle(),
              )),
              const SizedBox(height: 28),

              // --- Sign Up Button ---
              Obx(() => SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value ? null : controller.onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B0FCC),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text('Sign Up',
                          style: GoogleFonts.balsamiqSans(
                              fontSize: 18, color: Colors.white)),
                ),
              )),

              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? ',
                      style: GoogleFonts.balsamiqSans(
                          fontSize: 15, color: Colors.grey)),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text('Sign in',
                        style: GoogleFonts.balsamiqSans(
                            fontSize: 15,
                            color: const Color(0xff5B13EC),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Expanded(child: Divider(color: Colors.grey, endIndent: 16)),
                  Text('Or continues with',
                      style: GoogleFonts.balsamiqSans(
                          fontSize: 15, color: Colors.grey)),
                  const Expanded(child: Divider(color: Colors.grey, indent: 16)),
                ],
              ),
              const SizedBox(height: 28),
              _buildSocialButton(
                label: 'Google',
                iconWidget: Image.asset('assets/flat-color-icons_google.png',
                    width: 20, height: 20),
                onTap: controller.onGoogleSignUp,
              ),
              const SizedBox(height: 12),
              _buildSocialButton(
                label: 'Facebook',
                iconWidget: Image.asset('assets/logos_facebook.png',
                    width: 20, height: 20),
                onTap: controller.onFacebookSignUp,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool obscure = false,
    VoidCallback? onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: GoogleFonts.balsamiqSans(color: Colors.black, fontSize: 16),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black38, fontSize: 16),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          suffixIcon: onToggle != null
              ? IconButton(
                  icon: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey),
                  onPressed: onToggle,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String label,
    required Widget iconWidget,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE0D6F5)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,
            const SizedBox(width: 10),
            Text(label,
                style: GoogleFonts.balsamiqSans(
                    fontSize: 15, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}