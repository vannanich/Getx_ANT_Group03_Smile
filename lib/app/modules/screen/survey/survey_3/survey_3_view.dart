import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';
import 'package:flutter_application_1/app/core/widgets/app_button_eleveted.dart';
import 'package:flutter_application_1/app/core/widgets/app_button_outline.dart';
import 'package:flutter_application_1/app/core/widgets/app_grid.dart';
import 'package:flutter_application_1/app/core/widgets/app_stepper.dart';
import 'package:get/get.dart';

part 'survey_3_binding.dart';
part 'survey_3_controller.dart';

class Survey3View extends GetView<Survey3ViewController> {
  const Survey3View({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> myData = [
      {'title': 'Motivation', 'image': 'assets/need_most/💪.png'},
      {'title': 'Calm', 'image': 'assets/need_most/🧘.png'},
      {'title': 'Focus', 'image': 'assets/need_most/💡.png'},
      {'title': 'Happiness', 'image': 'assets/need_most/😊.png'},
      {'title': 'Sleep', 'image': 'assets/need_most/🌙.png'},
      {'title': 'Self-Love', 'image': 'assets/need_most/❤️.png'},
      {'title': 'Clarity', 'image': 'assets/need_most/🧠.png'},
      {'title': 'Energy', 'image': 'assets/need_most/⚡.png'},
      {'title': 'Connection', 'image': 'assets/need_most/🤝.png'},
    ];
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            AppStepper(currentPage: 2, totalSteps: 6),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.survey_2);
              },
              child: Icon(Icons.arrow_back, size: 30),
            ),
            SizedBox(height: 20),
            _buildBody(),
            SizedBox(height: 30),
            Expanded(child: AppGrid(items: myData)),

            AppButtonOutline(
              title: "Skip",
              onPressed: () {
                Get.toNamed(AppRoutes.survey_4);
              },
            ),
            SizedBox(height: 10),
            AppButton(
              title: "Continue",
              onPressed: () {
                Get.toNamed(AppRoutes.survey_4);
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
                "What",
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "  do you need the most today ?",
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
          "  Choose what matter the most to you right now",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}
