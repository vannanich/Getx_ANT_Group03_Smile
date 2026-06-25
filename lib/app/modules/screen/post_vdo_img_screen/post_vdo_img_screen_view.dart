

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';
import 'package:flutter_application_1/app/core/widgets/app_button_eleveted.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

part 'post_vdo_img_screen_binding.dart';
part 'post_vdo_img_screen_controller.dart';

class PostVdoImgScreenView extends GetView<PostVdoImgScreenViewController> {
  const PostVdoImgScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 23),
              _buildPostVandI(),
              SizedBox(height: 20),
              _buildTextField(
                controller: controller.captionController,
                hint: 'Write a caption...',
                isMultiline: true,
              ),
              SizedBox(height: 13),
              _buildPreview(),

              Spacer(),
              AppButton(title: 'Next', onPressed: () {
                Get.toNamed(AppRoutes.information_video);
              },)
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
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.arrow_back,
                    size: 26, color: Colors.black87),
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Post Video',
                  style: GoogleFonts.balsamiqSans(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Review your appointment today',
                  style: GoogleFonts.balsamiqSans(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 32.5,
                    backgroundImage: AssetImage("assets/img/pro3.jpg"),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr.Latte!!",
                      style: GoogleFonts.balsamiqSans(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _buildPostVandI() {
    return Row(
      children: [
        /// VIDEO
        Expanded(
          child: GestureDetector(
            onTap: () {
              controller.pickVideo();
            },
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 218, 206, 241),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 220, 205, 252),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEADAF5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
                      "assets/img/video-play.png",
                      color: const Color(0xff407BFF),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Post Video",
                    style: GoogleFonts.balsamiqSans(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () {
              controller.pickImage();
            },
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 218, 206, 241),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 210, 191, 248),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEADAF5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset("assets/img/gallery.png"),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Post Image",
                    style: GoogleFonts.balsamiqSans(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildPreview() {
  return Obx(() {
    if (controller.selectedImagePath.value.isNotEmpty) {
      return Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: FileImage(
              File(controller.selectedImagePath.value),
            ),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    if (controller.selectedVideoPath.value.isNotEmpty) {
      return Container(
        width: double.infinity,
        height: 260,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.video_file,
              size: 60,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 10),
            Text(
              "Video Selected",
              style: GoogleFonts.balsamiqSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 260,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Center(
        child: Text(
          "Which one you want ?",
          style: GoogleFonts.balsamiqSans(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ),
    );
  });
}
  



  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool isMultiline = false,
    FocusNode? focusNode,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        maxLines: isMultiline ? 4 : 1,
        style: GoogleFonts.balsamiqSans(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.balsamiqSans(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }


  

}