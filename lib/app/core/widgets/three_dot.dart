import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';

class DotIndicator extends StatelessWidget {
  final int currentPage;
  const DotIndicator({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: currentPage == index ? 35 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: currentPage == index ? AppColors.secondary : Colors.grey,
            borderRadius: BorderRadius.circular(50),
          ),
        );
      }),
    );
  }
}