import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/onboarding/onboarding/onboarding_controller.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';
import 'package:flutter_application_1/app/core/widgets/three_dot.dart';
import 'package:get/get.dart';

part 'onboarding_binding.dart';

class OnboardingView extends GetView<OnboardingViewController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "Skip",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                _buildSpace(200),
                _buildBody(),
                SizedBox(height: 20),
                DotIndicator(currentPage:0),
                // _buildThreeDot(),
                _buildSpace(100),
                _buildButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpace(double space) {
    return Container(
      width: double.infinity,
      height: space,
      color: AppColors.primary,
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/onboarding_1.png"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Start your day with a SMILE",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Every day is a fresh start. Smile helps you focus on the good, lift \n your mood, and begin your day with positivity and confidence.",
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  // Widget _buildThreeDot() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //         width: 35,
  //         height: 10,
  //         decoration: BoxDecoration(
  //           color: controller.currentIndex.value==index?AppColors.secondary:Colors.grey,
  //           borderRadius: BorderRadius.circular(50),
  //         ),
  //       ),
  //       SizedBox(width: 10),
  //       Container(
  //         width: 35,
  //         height: 10,
  //         decoration: BoxDecoration(
  //           color: Colors.grey,
  //           borderRadius: BorderRadius.circular(50),
  //         ),
  //       ),
  //       SizedBox(width: 10),
  //       Container(
  //         width: 35,
  //         height: 10,
  //         decoration: BoxDecoration(
  //           color: Colors.grey,
  //           borderRadius: BorderRadius.circular(50),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  // Widget _buildThreeDot() {
  //   return Obx(
  //     () => Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: List.generate(3, (index) {
  //         return Container(
  //           margin: const EdgeInsets.symmetric(horizontal: 5),
  //           width: controller.currentIndex.value == index ? 35 : 10,
  //           height: 10,
  //           decoration: BoxDecoration(
  //             color: controller.currentIndex.value == index
  //                 ? AppColors.secondary
  //                 : Colors.grey,
  //             borderRadius: BorderRadius.circular(50),
  //           ),
  //         );
  //       }),
  //     ),
  //   );
  // }

  Widget _buildButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
        ),
        onPressed: () {
          controller.changePage(1);
          Get.toNamed(AppRoutes.onboarding_2);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Next", style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(width: 20),
            Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
