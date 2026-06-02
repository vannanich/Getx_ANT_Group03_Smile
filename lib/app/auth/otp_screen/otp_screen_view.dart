import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

part 'otp_screen_binding.dart';
part 'otp_screen_controller.dart';

class OtpScreenView extends GetView<OtpScreenViewController> {
  const OtpScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F0FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Email",
                    style: GoogleFonts.balsamiqSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff5B13EC),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Verification",
                    style: GoogleFonts.balsamiqSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                "Provide your email address to receive your OTP verification code.",
                style: GoogleFonts.balsamiqSans(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 5),
              Image.asset(
                "assets/img/img_otp_check.png",
                height: 350,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 15),
              TextField(
                style: GoogleFonts.balsamiqSans(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
                obscureText: false,
                decoration: InputDecoration(
                  hintText: "Enter Your Email",
                  hintStyle: GoogleFonts.spaceGrotesk(
                    color: Color(0xFF9B8AB8),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                  
                ),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF621CE4),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Next",
                  style: GoogleFonts.balsamiqSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
