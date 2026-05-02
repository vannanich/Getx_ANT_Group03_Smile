import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:flutter_application_1/app/shared/themes/app_colors.dart';
import 'package:flutter_application_1/app/shared/widgets/app_button_eleveted.dart';
import 'package:flutter_application_1/app/shared/widgets/app_button_outline.dart';
import 'package:flutter_application_1/app/shared/widgets/app_grid.dart';
import 'package:flutter_application_1/app/shared/widgets/app_stepper.dart';
import 'package:get/get.dart';

part 'survey_4_binding.dart';
part 'survey_4_controller.dart';

class Survey4View extends GetView<Survey4ViewController> {
  const Survey4View({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> myData = [
      {'title': 'Relax', 'image': 'assets/goals/🛋️.png'},
      {'title': 'Chill', 'image': 'assets/goals/🧊.png'},
      {'title': 'Be Productive', 'image': 'assets/goals/🎯.png'},
      {'title': 'Work Out', 'image': 'assets/goals/🏋️.png'},
      {'title': 'Learn', 'image': 'assets/goals/📖.png'},
      {'title': 'Creative', 'image': 'assets/goals/🎨.png'},
      {'title': 'Heal', 'image': 'assets/goals/🌿.png'},
      {'title': 'Socialize', 'image': 'assets/goals/🤝.png'},
      {'title': 'Rest', 'image': 'assets/goals/😴.png'},
    ];
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            AppStepper(currentPage: 3, totalSteps: 6),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.survey_3);
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
                Get.toNamed(AppRoutes.survey_5);
              },
            ),
            SizedBox(height: 10),
            AppButton(
              title: "Continue",
              onPressed: () {
                Get.toNamed(AppRoutes.survey_5);
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
                "  is your goal today ?",
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
          " Pick what you want to archive the most",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}
