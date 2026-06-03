import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

part 'choose_profile_screen_binding.dart';
part 'choose_profile_screen_controller.dart';

class ChooseProfileScreenView
    extends GetView<ChooseProfileScreenViewController> {
  const ChooseProfileScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F0FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 50),
              _buildProfilePicture(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Choose",
              style: GoogleFonts.balsamiqSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff5B13EC),
              ),
            ),
            SizedBox(width: 5),
            Text(
              "Profile",
              style: GoogleFonts.balsamiqSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Spacer(),
            Text(
              "Skip",
              style: GoogleFonts.balsamiqSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff5B13EC),
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Text(
          "Choose your profile picture",
          style: GoogleFonts.balsamiqSans(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildProfilePicture() {
    return GestureDetector(
      onTap: () => _showImagePickerSheet(),
      child: Obx(
        () => Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomRight,
          children: [
            // Circle Image
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: ClipOval(
                child: controller.pickedImage.value != null
                    ? Image.file(
                        controller.pickedImage.value!,
                        fit: BoxFit.cover,
                        width: 200,
                        height: 200,
                      )
                    : Image.asset(
                        'assets/logo_smile.png',
                        fit: BoxFit.cover,
                        width: 300,
                        height: 300,
                      ),
              ),
            ),
            Positioned(
              bottom: 12,
              right: 11,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF4B0FCC),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 23,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePickerSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 20),

            Text(
              'Choose Image',
              style: GoogleFonts.balsamiqSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),

            // Camera Option
            ListTile(
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.camera);
              },
              leading: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE0FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.camera_alt, color: Color(0xFF4B0FCC)),
              ),
              title: Text(
                'Take a Photo',
                style: GoogleFonts.balsamiqSans(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                'Use your camera',
                style: GoogleFonts.balsamiqSans(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ),
            Divider(height: 1),
            // Gallery Option
            ListTile(
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.gallery);
              },
              leading: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF4B0FCC),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              title: Text(
                'Choose from Gallery',
                style: GoogleFonts.balsamiqSans(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                'Pick from your photos',
                style: GoogleFonts.balsamiqSans(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.balsamiqSans(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
