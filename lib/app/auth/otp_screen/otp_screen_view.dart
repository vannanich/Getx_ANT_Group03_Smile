import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'otp_screen_binding.dart';
part 'otp_screen_controller.dart';

class OtpScreenView extends GetView<OtpScreenViewController> {
  const OtpScreenView({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: const Color(0xFFFDEEF1), 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              // Title Section
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(text: 'Email ', style: TextStyle(color: Colors.purple)),
                    TextSpan(text: 'Verification', style: TextStyle(color: Colors.black87)),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Provide your email address to receive your OTP verification code.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              
              Spacer(),
              
              // Illustration Image
              Center(
                child: Image.asset(
                  'assets/images/verification_img.png', // កុំភ្លេចដាក់រូបក្នុង assets
                  height: 250,
                ),
              ),
              
              Spacer(),

              // Email Input Field
              TextField(
              
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: const Color(0xFFFAE0E4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                ),
              ),
              
              SizedBox(height: 20),

              // Next Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}