// scale animation

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:getx_project_sample/screens/mood_selection/mood_selection_controller.dart';

// import '../model/mood_model.dart';

// class MoodGrid extends GetView<MoodSelectorController> {
//   final MoodQuestion question;

//   const MoodGrid({super.key, required this.question});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: MoodSelectorController.tileCount,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: 12,
//         mainAxisSpacing: 12,
//         childAspectRatio: 1,
//       ),
//       itemBuilder: (context, index) {
//         final mood = question.moods[index];

//         return Obx(() {
//           final isSelected = controller.selectedIndex.value == index;

//           return AnimatedBuilder(
//             animation: controller.tileControllers[index],
//             builder: (context, child) {
//               final t = controller.tileControllers[index].value;
//               final scale = 1.0 - (t * 0.45);
//               final opacity = 1.0 - t;

//               return Opacity(
//                 opacity: opacity.clamp(0.0, 1.0),
//                 child: Transform.scale(
//                   scale: scale.clamp(0.0, 1.2),
//                   child: child,
//                 ),
//               );
//             },
//             child: GestureDetector(
//               onTap: () => controller.selectMood(index),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 160),
//                 curve: Curves.easeOut,
//                 decoration: BoxDecoration(
//                   color: isSelected ? const Color(0xFFEDE4FF) : Colors.white,
//                   borderRadius: BorderRadius.circular(18),
//                   border: Border.all(
//                     color: isSelected
//                         ? const Color(0xFF6B3FD4)
//                         : Colors.transparent,
//                     width: 2,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: isSelected
//                           ? const Color(0xFF6B3FD4).withOpacity(0.18)
//                           : Colors.black.withOpacity(0.05),
//                       blurRadius: isSelected ? 14 : 6,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       mood.emoji,
//                       style: TextStyle(fontSize: isSelected ? 36 : 32),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       mood.label,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 11,
//                         fontWeight: isSelected
//                             ? FontWeight.w700
//                             : FontWeight.w500,
//                         color: isSelected
//                             ? const Color(0xFF6B3FD4)
//                             : const Color(0xFF5A4A7A),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//       },
//     );
//   }
// }

// opacity animation

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/mood_selection/mood_selection_controller.dart';
import 'package:get/get.dart';

import '../model/mood_model.dart';

class MoodGrid extends GetView<MoodSelectorController> {
  final MoodQuestion question;

  const MoodGrid({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: MoodSelectorController.tileCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 30,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, index) {
        final mood = question.moods[index];

        return Obx(() {
          final isSelected = controller.selectedIndex.value == index;

          return GestureDetector(
            onTap: () => controller.selectMood(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFEDE4FF) : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF6B3FD4)
                      : Colors.transparent,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? const Color(0xFF6B3FD4).withOpacity(0.18)
                        : Colors.black.withOpacity(0.05),
                    blurRadius: isSelected ? 14 : 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: controller.tileControllers[index],
                    builder: (context, child) {
                      final t = controller.tileControllers[index].value;
                      final opacity = (1.0 - t).clamp(0.0, 1.0);

                      return Opacity(opacity: opacity, child: child);
                    },
                    // child: Text(
                    //   mood.imagePath,
                    //   style: TextStyle(fontSize: isSelected ? 36 : 32),
                    // ),
                    child: mood.imagePath.startsWith('assets/')
                        ? Image.asset(
                            mood.imagePath,
                            width: isSelected ? 42 : 36,
                            height: isSelected ? 42 : 36,
                            errorBuilder: (_, _, _) =>
                                const Icon(Icons.image_not_supported, size: 32),
                          )
                        : Text(
                            mood.imagePath,
                            style: TextStyle(fontSize: isSelected ? 36 : 32),
                          ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    mood.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected
                          ? const Color(0xFF6B3FD4)
                          : const Color(0xFF5A4A7A),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
