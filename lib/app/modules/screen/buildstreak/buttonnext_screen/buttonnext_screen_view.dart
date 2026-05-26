import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

part 'buttonnext_screen_binding.dart';
part 'buttonnext_screen_controller.dart';

class ButtonnextScreenView extends GetView<ButtonnextScreenViewController> {
  const ButtonnextScreenView({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: Column(
        children: [
          _buildHeader(context), 
          SizedBox(height: 20),
          _buildbutton()
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(color: const Color(0xFFF6D6E9)),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.50,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFB57EDC), // purple color
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(200),
                bottomRight: Radius.circular(200),
              ),
            ),
          ),
        ),
        Positioned(
          top: 65,
          left: 58,
          child: Center(
            child: Image.asset(
              'assets/img/img2.png',
              width: 310,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildbutton() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(13),
          child: Container(
            width: 800,
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(96, 208, 240, 210),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(132, 185, 240, 192),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.medical_services_outlined,
                    size: 30,
                    color: Colors.brown,
                  ),
                ),

                SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Continue as a doctor",
                          style: GoogleFonts.balsamiqSans(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown.shade700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Be a doctor to comfort patient",
                          style: GoogleFonts.balsamiqSans(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(13),
              child: Container(
                width: 800,
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Color(0xFFEBEBFF),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color.fromARGB(255, 196, 196, 247)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(132, 185, 240, 192),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.person_3_outlined,
                        size: 30,
                        color: Colors.brown,
                      ),
                    ),

                    SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Continue as a user",
                              style: GoogleFonts.balsamiqSans(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown.shade700,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Come to us for the encuragement",
                              style: GoogleFonts.balsamiqSans(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 73),
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () => Get.toNamed("/letBeginWithUs"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B13EC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Continue",
                style: GoogleFonts.balsamiqSans(fontSize: 23,color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
      ],   
    );
  }
}