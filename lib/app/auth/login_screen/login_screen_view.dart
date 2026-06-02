import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'login_screen_controller.dart';

class LoginScreenView extends GetView<LoginScreenController> {
   LoginScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFF4F0FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(height: 30),
              _buildLogo(),
               SizedBox(height: 20),
              _buildTitle(),
               SizedBox(height: 54),
              _buildEmailField(),
               SizedBox(height: 14),
              _buildPasswordField(),
               SizedBox(height: 8),
              _buildForgotPassword(),
               SizedBox(height: 20),
              _buildSignInButton(),
               SizedBox(height: 12),
              _buildGuestButton(),
               SizedBox(height: 16),
              _buildSignUpRow(),
               SizedBox(height: 16),
              _buildDivider(),
               SizedBox(height: 16),
              _buildFacebookButton(),
               SizedBox(height: 12),
              _buildGoogleButton(),
               SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          color:  Color(0xFFE8E0FF),
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 70,
              height: 70,
              errorBuilder: (_, __, ___) =>  Icon(
                Icons.mood,
                size: 60,
                color: Color(0xFF6B3FD4),
              ),
            ),
            Text(
              'smile',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF6B3FD4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sing In',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Color(0xFF2D1B6B),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Sign in into your exist account',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF9B8AB8),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: TextField(
        controller: controller.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration:  InputDecoration(
          hintText: 'Email',
          hintStyle: TextStyle(color: Color(0xFF9B8AB8), fontSize: 14),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
            ),
          ],
        ),
        child: TextField(
          controller: controller.passwordController,
          obscureText: controller.isPasswordHidden.value,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle:  TextStyle(color: Color(0xFF9B8AB8), fontSize: 14),
            border: InputBorder.none,
            contentPadding:  EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            suffixIcon: GestureDetector(
              onTap: controller.togglePassword,
              child: Icon(
                controller.isPasswordHidden.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color:  Color(0xFF9B8AB8),
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: controller.onForgotPassword,
        child:  Text(
          'Forgot password?',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF6B3FD4),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return Obx(
      () => ElevatedButton(
        onPressed: controller.isLoading.value ? null : controller.onSignIn,
        style: ElevatedButton.styleFrom(
          minimumSize:  Size(double.infinity, 52),
          backgroundColor:  Color(0xFF5B2DC4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 4,
          shadowColor:  Color(0xFF5B2DC4).withOpacity(0.35),
        ),
        child: controller.isLoading.value
            ?  SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            :  Text(
                'Sign in',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }

  Widget _buildGuestButton() {
    return OutlinedButton(
      onPressed: controller.onContinueAsGuest,
      style: OutlinedButton.styleFrom(
        minimumSize:  Size(double.infinity, 52),
        side:  BorderSide(color: Color(0xFF6B3FD4), width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child:  Text(
        'Continue as guest',
        style: TextStyle(
          color: Color(0xFF6B3FD4),
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _buildSignUpRow() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(
            "Don't have an account? ",
            style: TextStyle(fontSize: 13, color: Color(0xFF9B8AB8)),
          ),
          GestureDetector(
            onTap: controller.onSignUp,
            child:  Text(
              'Sign up',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF6B3FD4),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return  Row(
      children: [
        Expanded(child: Divider(color: Color(0xFFE0D8F0))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Or continues with',
            style: TextStyle(fontSize: 12, color: Color(0xFF9B8AB8)),
          ),
        ),
        Expanded(child: Divider(color: Color(0xFFE0D8F0))),
      ],
    );
  }

  Widget _buildFacebookButton() {
    return ElevatedButton.icon(
      onPressed: controller.onFacebook,
      icon:  Icon(Icons.facebook, color: Colors.white, size: 20),
      label:  GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.moodSelection);
        },
        child: Text(
          'CONTINUE WITH FACEBOOK',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 13,
            letterSpacing: 0.5,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize:  Size(double.infinity, 52),
        backgroundColor:  Color(0xFF6B3FD4).withOpacity(0.85),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 0,
      ),
    );
  }

  Widget _buildGoogleButton() {
    return OutlinedButton.icon(
      onPressed: controller.onGoogle,
      icon: Image.asset(
        'assets/images/google.png',
        width: 20,
        height: 20,
        errorBuilder: (_, __, ___) =>  Icon(
          Icons.g_mobiledata,
          color: Color(0xFF6B3FD4),
          size: 24,
        ),
      ),
      label:  Text(
        'CONTINUE WITH GOOGLE',
        style: TextStyle(
          color: Color(0xFF2D1B6B),
          fontWeight: FontWeight.w700,
          fontSize: 13,
          letterSpacing: 0.5,
        ),
      ),
      style: OutlinedButton.styleFrom(
        minimumSize:  Size(double.infinity, 52),
        side:  BorderSide(color: Color(0xFFE0D8F0), width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}