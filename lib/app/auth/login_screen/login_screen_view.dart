import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen_controller.dart';

class LoginScreenView extends GetView<LoginScreenController> {
  const LoginScreenView({super.key});

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

              // Logo
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

              // Title
              Row(
                children: [
                  Text("Sign",
                      style: GoogleFonts.balsamiqSans(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff5B13EC))),
                  const SizedBox(width: 5),
                  Text("In",
                      style: GoogleFonts.balsamiqSans(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
              const SizedBox(height: 4),
              Text('Sign in to your account',
                  style: GoogleFonts.balsamiqSans(
                      fontSize: 15, color: Colors.grey)),
              const SizedBox(height: 24),

              // Email field
              Obx(() => _buildTextField(
                    hint: 'Email',
                    icon: Icons.email_outlined,
                    controller: controller.emailController,
                    errorText: controller.emailError.value,
                  )),
              const SizedBox(height: 14),

              // Password field
              Obx(() => _buildTextField(
                    hint: 'Password',
                    icon: Icons.lock_outline,
                    controller: controller.passwordController,
                    obscure: !controller.isPasswordVisible.value,
                    errorText: controller.passwordError.value,
                    onToggle: controller.togglePasswordVisibility,
                  )),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: controller.onForgotPassword,
                  child: Text('Forgot Password?',
                      style: GoogleFonts.balsamiqSans(
                          fontSize: 13,
                          color: const Color(0xff5B13EC),
                          fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 8),

              // Sign In button
              Obx(() => SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed:
                          controller.isLoading.value ? null : controller.signIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4B0FCC),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text('Sign In',
                              style: GoogleFonts.balsamiqSans(
                                  fontSize: 18, color: Colors.white)),
                    ),
                  )),
              const SizedBox(height: 12),

              // Continue as guest
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: controller.continueAsGuest,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF4B0FCC)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text('Continue as Guest',
                      style: GoogleFonts.balsamiqSans(
                          fontSize: 16, color: const Color(0xFF4B0FCC))),
                ),
              ),
              const SizedBox(height: 18),

              // Sign up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ",
                      style: GoogleFonts.balsamiqSans(
                          fontSize: 15, color: Colors.grey)),
                  GestureDetector(
                    onTap: controller.onSignUp,
                    child: Text('Sign Up',
                        style: GoogleFonts.balsamiqSans(
                            fontSize: 15,
                            color: const Color(0xff5B13EC),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline)),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Divider
              Row(
                children: [
                  const Expanded(
                      child: Divider(color: Colors.grey, endIndent: 16)),
                  Text('Or continues with',
                      style: GoogleFonts.balsamiqSans(
                          fontSize: 15, color: Colors.grey)),
                  const Expanded(
                      child: Divider(color: Colors.grey, indent: 16)),
                ],
              ),
              const SizedBox(height: 20),

              // Google button
              _buildSocialButton(
                label: 'Google',
                iconWidget: Image.asset(
                    'assets/flat-color-icons_google.png',
                    width: 20,
                    height: 20),
                onTap: controller.signInWithGoogle,
              ),
              const SizedBox(height: 12),

              // Facebook button
              _buildSocialButton(
                label: 'Facebook',
                iconWidget: Image.asset('assets/logos_facebook.png',
                    width: 20, height: 20),
                onTap: controller.signInWithFacebook,
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
    String errorText = '',
    VoidCallback? onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.75),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: errorText.isNotEmpty
                  ? Colors.red
                  : Colors.white,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: GoogleFonts.balsamiqSans(color: Colors.black, fontSize: 16),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:
                  const TextStyle(color: Colors.black38, fontSize: 16),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 15),
              suffixIcon: onToggle != null
                  ? IconButton(
                      icon: Icon(
                          obscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey),
                      onPressed: onToggle,
                    )
                  : null,
            ),
          ),
        ),
        if (errorText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Text(errorText,
                style: const TextStyle(color: Colors.red, fontSize: 12)),
          ),
      ],
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