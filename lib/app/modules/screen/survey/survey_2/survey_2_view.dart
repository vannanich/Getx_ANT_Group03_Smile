import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';
import 'package:flutter_application_1/app/core/widgets/app_button_eleveted.dart';
import 'package:flutter_application_1/app/core/widgets/app_button_outline.dart';
import 'package:flutter_application_1/app/core/widgets/app_grid.dart';
import 'package:flutter_application_1/app/core/widgets/app_stepper.dart';
import 'package:get/get.dart';

part 'survey_2_binding.dart';
part 'survey_2_controller.dart';

class Survey2View extends GetView<Survey2ViewController> {
  const Survey2View({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> myData = [
      {'title': 'Calm', 'image': 'assets/Feeling/😊.png'},
      {'title': 'Calm', 'image': 'assets/Feeling/😌.png'},
      {'title': 'Sad', 'image': 'assets/Feeling/😢.png'},
      {'title': 'Angry', 'image': 'assets/Feeling/😤.png'},
      {'title': 'Anxious', 'image': 'assets/Feeling/😢.png'},
      {'title': 'Tired', 'image': 'assets/Feeling/😴.png'},
      {'title': 'love', 'image': 'assets/Feeling/🥰.png'},
      {'title': 'Exited', 'image': 'assets/Feeling/🤩.png'},
      {'title': 'Confused', 'image': 'assets/Feeling/🤔 (1).png'},
    ];
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            AppStepper(currentPage: 1, totalSteps: 6),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.survey_1);
              },
              child: Icon(Icons.arrow_back, size: 30),
            ),
            SizedBox(height: 20),
            _buildBody(),
            SizedBox(height: 30),

            // Expanded(child: AppGrid(items: myData)),
            // Expanded(
            // child: AppGrid(items: myData, controller: controller),
            // ),
            Expanded(child: AppGrid(items: myData)),

            AppButtonOutline(
              title: "Skip",
              onPressed: () {
                Get.toNamed(AppRoutes.survey_3);
              },
            ),
            SizedBox(height: 10),
            AppButton(
              title: "Continue",
              onPressed: () {
                Get.toNamed(AppRoutes.survey_3);
              },
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "How",
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "  are you feeling today ?",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(
          "  are you feeling today",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}
