import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
              SizedBox(height: 40),
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
              SizedBox(height: 36),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Sign",
                        style: GoogleFonts.balsamiqSans(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff5B13EC),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Up",
                        style: GoogleFonts.balsamiqSans(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Sign up your account',
                    style: GoogleFonts.balsamiqSans(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 24),
              Column(
                children: [
                  _buildTextField(
                    hint: 'Username',
                    icon: Icons.person_outline,
                  ),
                  SizedBox(height: 14),
                  _buildTextField(
                    hint: 'Password',
                    icon: Icons.lock_outline,
                    obscure: true,
                  ),
                  SizedBox(height: 14),
                  _buildTextField(
                    hint: 'Confirm password',
                    icon: Icons.lock_outline,
                    obscure: true,
                  ),
                  SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4B0FCC),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.login);
                        },
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.balsamiqSans(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: GoogleFonts.balsamiqSans(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 4),
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Text(
                                'Sign in',
                                style: GoogleFonts.balsamiqSans(
                                  fontSize: 15,
                                  color: const Color(0xff5B13EC),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [

                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                                endIndent: 16,
                              ),
                            ),
                            Text(
                              'Or continues with',
                              style: GoogleFonts.balsamiqSans(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                                indent: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 28),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSocialButton(
                        label: 'Google',
                        iconWidget: Image.asset(
                          'assets/flat-color-icons_google.png',
                          width: 20,
                          height: 20,
                        ),
                        
                        onTap: controller.onGoogleSignUp,
                      ),
                      SizedBox(height: 12),
                      _buildSocialButton(
                        label: 'Facebook',
                        iconWidget: Image.asset(
                          'assets/logos_facebook.png',
                          width: 20,
                          height: 20,
                        ),
                        onTap: controller.onFacebookSignUp,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: TextField(
        obscureText: obscure,
        style: GoogleFonts.balsamiqSans(
          color: Colors.black,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black38,
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
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
        border: Border.all(color: const Color(0xFFE0D6F5), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconWidget,
          SizedBox(width: 10),
          Text(
            label,
            style: GoogleFonts.balsamiqSans(
              fontSize: 15,
              color: Colors.black87,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    ),
  );
}
}