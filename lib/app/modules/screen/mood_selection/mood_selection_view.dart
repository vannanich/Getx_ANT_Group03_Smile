import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/mood_selection/mood_selection_controller.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';
import 'package:get/get.dart';

import 'model/mood_model.dart';
import 'widget/mood_widget.dart';

class MoodSelectorScreen extends StatelessWidget {
  const MoodSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoodSelectorController>(
      init: MoodSelectorController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF4F0FF),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      if (controller.questionIndex.value > 0 &&
                          !controller.isTransitioning.value) {
                        controller.onBack();
                      }
                    },
                    child: Obx(
                      () => AnimatedOpacity(
                        opacity: controller.questionIndex.value > 0
                            ? 1.0
                            : 0.25,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.07),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 15,
                            color: Color(0xFF6B3FD4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Obx(
                              () => Text(
                                '${controller.questionIndex.value + 1} of ${questions.length}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF9B8AB8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: AnimatedBuilder(
                                animation: controller.progressAnimation,
                                builder: (context, child) {
                                  return LinearProgressIndicator(
                                    value: controller.progressAnimation.value,
                                    minHeight: 6,
                                    backgroundColor: const Color(
                                      0xFF6B3FD4,
                                    ).withOpacity(0.12),
                                    valueColor: const AlwaysStoppedAnimation(
                                      Color(0xFF6B3FD4),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 280),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (child, anim) => FadeTransition(
                      opacity: anim,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.05),
                          end: Offset.zero,
                        ).animate(anim),
                        child: child,
                      ),
                    ),
                    child: Obx(() {
                      final q = controller.currentQuestion;
                      return Center(
                        child: Column(
                          key: ValueKey(controller.questionIndex.value),
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: q.highlight,
                                    style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF6B3FD4),
                                    ),
                                  ),
                                  TextSpan(
                                    text: q.rest,
                                    style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2D1B6B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              q.subtitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 50),

                  Expanded(
                    child: Obx(
                      () => MoodGrid(question: controller.currentQuestion),
                    ),
                  ),

                  const SizedBox(height: 14),

                  OutlinedButton(
                    onPressed: controller.onSkip,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 52),
                      side: const BorderSide(
                        color: Color(0xFF6B3FD4),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Color(0xFF6B3FD4),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Obx(
                    () => AnimatedOpacity(
                      duration: const Duration(milliseconds: 180),
                      opacity: controller.canContinue ? 1.0 : 0.4,
                      child: ElevatedButton(
                        onPressed: controller.canContinue
                            ? controller.onContinue
                            : null,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 52),
                          backgroundColor: const Color(0xFF5B2DC4),
                          disabledBackgroundColor: const Color(0xFF5B2DC4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 4,
                          shadowColor: const Color(
                            0xFF5B2DC4,
                          ).withOpacity(0.35),
                        ),
                        child: Text(
                          controller.questionIndex.value == questions.length - 1
                              ? 'Finish'
                              : 'Continue',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
