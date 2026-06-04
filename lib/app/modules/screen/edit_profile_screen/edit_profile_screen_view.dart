import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/shared/themes/app_colors.dart';
import 'package:flutter_application_1/app/shared/widgets/app_button_eleveted.dart';
import 'package:get/get.dart';

part 'edit_profile_screen_binding.dart';
part 'edit_profile_screen_controller.dart';

class EditProfileScreenView extends GetView<EditProfileScreenViewController> {
  const EditProfileScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff424242),
              ),
            ),
            Text(
              'modify your information',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xffACA8B3),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            _buildProfile(),
            SizedBox(height: 50),
            _buildTextField('Username', 'assets/profile.png'),
            SizedBox(height: 15),
            _buildTextField('Email', 'assets/sms.png'),
            SizedBox(height: 30),
            AppButton(
              title: 'Save ',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              // PROFILE IMAGE
              ClipOval(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    'https://www.shutterstock.com/shutterstock/photos/2368533593/display_1500/stock-photo-cute-profile-pictures-halloween-themed-2368533593.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset("assets/camera.png",
                        width: 16, height: 16)),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Center(
          child: Text(
            'Username',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String imagePath) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            imagePath,
            width: 20,
            height: 20,
          ),
        ),
      ),
    );
  }
}
