import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/mood_selection/model/mood_model.dart';
import 'package:flutter_application_1/app/modules/screen/mood_selection/mood_selection_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ResultsSheet extends StatelessWidget {
  final MoodSelectorController controller;
  const ResultsSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE0D8F0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Your mood snapshot',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2D1B6B),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Here\'s how you\'re doing across the board',
            style: TextStyle(fontSize: 13, color: Color(0xFF9B8AB8)),
          ),
          const SizedBox(height: 20),
          ...List.generate(controller.answers.length, (i) {
            final q = questions[i];
            final mood = q.moods[controller.answers[i]];

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Text(mood.emoji, style: const TextStyle(fontSize: 28)),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          q.highlight + q.rest,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF9B8AB8),
                          ),
                        ),
                        Text(
                          mood.label,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2D1B6B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: Get.back,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              backgroundColor: const Color(0xFF5B2DC4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Done',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
