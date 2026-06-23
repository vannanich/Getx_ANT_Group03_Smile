import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';
import 'package:flutter_application_1/app/core/widgets/app_button_eleveted.dart';
import 'package:flutter_application_1/app/core/widgets/app_button_outline.dart';
import 'package:flutter_application_1/app/core/widgets/app_space.dart';
import 'package:flutter_application_1/app/core/widgets/app_stepper.dart';
import 'package:get/get.dart';

part 'survey_1_binding.dart';
part 'survey_1_controller.dart';

class Survey1View extends GetView<Survey1ViewController> {
  const Survey1View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            AppStepper(currentPage: 0, totalSteps: 6),
            AppSpace(height: 120),
            SizedBox(height: 20),
            _buildSelectAge(),
            AppSpace(height: 85),

            AppButtonOutline(
              title: "Skip",
              onPressed: () {
                Get.toNamed(AppRoutes.survey_2);
              },
            ),
            SizedBox(height: 10),
            AppButton(
              title: "Continue",
              icon: Icons.arrow_forward,
              onPressed: () {
                Get.toNamed(AppRoutes.survey_2);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectAge() {
    const double itemHeight = 50.0;
    const double wheelHeight = 350.0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "How old are you?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            "Please select your age",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),

          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: itemHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(10),
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: const Color.fromARGB(255, 108, 54, 216),
                      width: 1,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: wheelHeight,

                child: ListWheelScrollView(
                  itemExtent: itemHeight,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {},
                  children: List.generate(
                    80,
                    (index) => Center(
                      child: Text(
                        "${index + 13}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
