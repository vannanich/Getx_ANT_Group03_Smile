import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';
import 'package:flutter_application_1/app/core/widgets/three_dot.dart';
import 'package:get/get.dart';

part 'onboarding_2_binding.dart';
part 'onboarding_2_controller.dart';

class Onboarding2View extends GetView<Onboarding2ViewController> {
  const Onboarding2View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "Skip",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildSpacer(200),
            _buildBody(),
            SizedBox(height: 20),
            DotIndicator(currentPage: 1),

            // _buildThreeDot(),
            _buildSpacer(100),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildSpacer(double space) {
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
              image: AssetImage("assets/onboarading_2.png"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Small Smiles , Big Impact",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "A smile can go a long way. Inspire others, share positivity, and be part ",
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        Text(
          " of a space built on kindness and encouragement.",
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
  //           width: 35,
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

  Widget _buildFooter() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.secondary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Get.toNamed(AppRoutes.onboarding);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 20),
                  Text(
                    "Back",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                controller.changePage(2);
                Get.toNamed(AppRoutes.onboarding_3);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Next",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
