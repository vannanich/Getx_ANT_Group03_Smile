import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class ChooseProfileScreenView
    extends GetView<ChooseProfileScreenView> {
  const ChooseProfileScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 229, 250),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TOP TEXT
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose",
                      style: GoogleFonts.balsamiqSans(
                        fontSize: 22,
                        color: const Color(0xFF5B13EC),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Profile",
                      style: GoogleFonts.balsamiqSans(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Skip",
                      style: GoogleFonts.balsamiqSans(
                        fontSize: 22,
                        color: const Color(0xFF5B13EC),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  "Choose your profile picture",
                  style: GoogleFonts.balsamiqSans(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Center(
                    child: Obx(
                      () => Stack(
                        children: [
                          /// IMAGE
                          Container(
                            width: 200,
                            height: 200,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: ClipOval(
                              child: controller.selectedImage.value != null
                                  ? Image.file(
                                      controller.selectedImage.value!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/img_logo_profiel.png",
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),

                          /// CAMERA BUTTON
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: InkWell(
                              onTap: () {
                                Get.bottomSheet(
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.camera_alt),
                                          title: Text("Camera"),
                                          onTap: () {
                                            Get.back();
                                            controller.pickImage(
                                              ImageSource.camera,
                                            );
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.image),
                                          title: Text("Gallery"),
                                          onTap: () {
                                            Get.back();
                                            controller.pickImage(
                                              ImageSource.gallery,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                padding: const EdgeInsets.all(9),
                                decoration: BoxDecoration(
                                  color: Color(0xFF5B13EC),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5B13EC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      "Next",
                      style: GoogleFonts.balsamiqSans(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
