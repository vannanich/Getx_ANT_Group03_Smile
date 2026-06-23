import 'package:flutter/material.dart';

class AppGrid extends StatelessWidget {
  final List<Map<String, String>> items;
  final int crossAxisCount;

  const AppGrid({super.key, required this.items, this.crossAxisCount = 3});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        return Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(item['image'] ?? ''),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item['title'] ?? '',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/app/modules/screen/survey/survey_2/survey_2_view.dart';
// import 'package:flutter_application_1/app/shared/themes/app_colors.dart';
// import 'package:get/get.dart';

// class AppGrid extends StatelessWidget {
//   final List<Map<String, String>> items;
//   final Survey2ViewController controller;

//   const AppGrid({super.key, required this.items, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return GridView.builder(
//         itemCount: items.length,
//         padding: const EdgeInsets.all(10),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           mainAxisSpacing: 10,
//           crossAxisSpacing: 10,
//         ),
//         itemBuilder: (context, index) {
//           final item = items[index];
//           final isSelected = controller.selectedGrid.value == index;

//           return GestureDetector(
//             onTap: () {
//               controller.selectedGrid.value = index;
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: isSelected ? AppColors.secondary : Colors.grey,
//                   width: isSelected ? 3 : 1,
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(item['image']!, height: 50),
//                   const SizedBox(height: 5),
//                   Text(item['title']!),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     });
//   }
// }
