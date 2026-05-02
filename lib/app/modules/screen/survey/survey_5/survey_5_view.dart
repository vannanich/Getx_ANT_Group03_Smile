import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/survey/survey_2/survey_2_view.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:flutter_application_1/app/shared/themes/app_colors.dart';
import 'package:flutter_application_1/app/shared/widgets/app_button_eleveted.dart';
import 'package:flutter_application_1/app/shared/widgets/app_button_outline.dart';
import 'package:flutter_application_1/app/shared/widgets/app_grid.dart';
import 'package:flutter_application_1/app/shared/widgets/app_stepper.dart';
import 'package:get/get.dart';

part 'survey_5_binding.dart';

class Survey5View extends GetView<Survey2ViewController> {
  const Survey5View({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> myData = [
      {'title': 'Mindfulness', 'image': 'assets/building_skill/🧘.png'},
      {'title': 'Communication', 'image': 'assets/building_skill/💬.png'},
      {'title': 'Time Management', 'image': 'assets/building_skill/⏰.png'},
      {'title': 'Discipline', 'image': 'assets/building_skill/💪.png'},
      {'title': 'Focus', 'image': 'assets/building_skill/🎯 (1).png'},
      {'title': 'Self-Care', 'image': 'assets/building_skill/❤️.png'},
      {'title': 'Critical-Thinking', 'image': 'assets/building_skill/🧠.png'},
      {'title': 'Leader-Ship', 'image': 'assets/building_skill/🤝 (2).png'},
      {'title': 'Creativity', 'image': 'assets/building_skill/🎨 (2).png'},
    ];
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            AppStepper(currentPage: 4, totalSteps: 6),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.survey_4);
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
                Get.toNamed(AppRoutes.survey_6);
              },
            ),
            SizedBox(height: 10),
            AppButton(
              title: "Continue",
              onPressed: () {
                Get.toNamed(AppRoutes.survey_6);
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
                "What ",
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "make you smile ?",
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
          "  Pick the thinig that brings yoou the most joy",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}
