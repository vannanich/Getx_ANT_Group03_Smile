import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

part 'otp_screen_send_code_binding.dart';
part 'otp_screen_send_code_controller.dart';

class OtpScreenSendCodeView extends GetView<OtpScreenSendCodeViewController> {
  const OtpScreenSendCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> controllers = List.generate(6, (_) => TextEditingController());
    final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

    return Scaffold(
      backgroundColor: Color(0xffF5F0FF),
      body: SafeArea(
        child: SingleChildScrollView( 
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Row(
                  children: [
                    Text(
                      "Email", 
                      style: GoogleFonts.balsamiqSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:  Color(0xff5B13EC),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Verification Code",
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
                  "A one-time password has been sent to s**@gmail.com**. Enter it to verify your account.",
                  style: GoogleFonts.balsamiqSans(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 15),
                Image.asset(
                  "assets/Confirmed-pana 1.png",
                  height: 250, 
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 48,
                      height: 56,
                      child: ValueListenableBuilder<TextEditingValue>(
                        valueListenable: controllers[index],
                        builder: (context, value, child) {
                          bool isFilled = value.text.isNotEmpty;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            decoration: BoxDecoration(
                              color: isFilled ? const Color(0xFF621CE4) : const Color(0xFFE5DAFC),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: TextField(
                              controller: controllers[index],
                              focusNode: focusNodes[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              style: GoogleFonts.balsamiqSans(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isFilled ? Colors.white : Colors.black38,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: const InputDecoration(
                                counterText: "", 
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 12),
                              ),
                              onChanged: (text) {
                                if (text.isNotEmpty && index < 5) {
                                  focusNodes[index + 1].requestFocus();
                                }
                                if (text.isEmpty && index > 0) {
                                  focusNodes[index - 1].requestFocus();
                                }
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ),              
                SizedBox(height: 30),      
                ElevatedButton(
                  onPressed: () {
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF621CE4),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Updated to rounded pill style
                    ),
                    elevation: 0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.login);
                    },
                    child: Text(
                      "Verify", 
                      style: GoogleFonts.balsamiqSans(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive the code? ",
                          style: GoogleFonts.balsamiqSans(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Resend",
                          style: GoogleFonts.balsamiqSans(
                            fontSize: 15,
                            color: Color(0xFF621CE4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}