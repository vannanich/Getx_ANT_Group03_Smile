// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// part 'buildstreak_binding.dart';
// part 'buildstreak_controller.dart';

// class BuildstreakView extends GetView<BuildstreakViewController> {
//   const BuildstreakView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 100,
//         centerTitle: true,
//         title: Padding(
//           padding: const EdgeInsets.only(top: 20),
//           child: const Text(
//             "Congratulations!",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 26,
//             ),
//           ),
//         ),
//       ),

//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             SizedBox(height: 40),
//             Image.asset(
//               "assets/img/Streak.png",
//               height: 180,
//             ),
//             SizedBox(height: 20),
//             Text(
//               "2",
//               style: TextStyle(
//                 fontSize: 68,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepOrange,
//               ),
//             ),

//             Text(
//               "days streak",
//               style: TextStyle(
//                 color: Colors.deepOrange,
//                 fontSize: 48,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 30),
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFEADFFF),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
//                         .map((day) => Text(day))
//                         .toList(),
//                   ),
//                   SizedBox(height: 10),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: List.generate(7, (index) {
//                       if (index < 2) {
//                         return const CircleAvatar(
//                           radius: 14,
//                           backgroundColor: Colors.orange,
//                           child: Icon(
//                             Icons.check,
//                             size: 16, color: Colors.white
//                           ),
//                         );
//                       } else {
//                         return CircleAvatar(
//                           radius: 10,
//                           backgroundColor: Colors.purple.shade100,
//                         );
//                       }
//                     }),
//                   ),

//                   SizedBox(height: 10),

//                   Text(
//                     "Let's move forward, giving up is not an option",
//                     style: TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.normal,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 85),
//             SizedBox(
//               width: double.infinity,
//               height: 55,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Get.toNamed("/letBeginWithUs");
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF5B13EC),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//                 child: const Text(
//                   "Continue",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_version2/screens/buildstreak/buildstreak_controller.dart';

// Assuming these are your file paths
// part 'buildstreak_binding.dart';
// part 'buildstreak_controller.dart';

class BuildstreakView extends GetView<BuildstreakViewController> {
  const BuildstreakView({super.key});

  @override
  Widget build(BuildContext context) {
    final int streakCount = 2;
    final List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            "Congratulations!",
            style: GoogleFonts.balsamiqSans(fontSize: 33),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 35),
            Image.asset("assets/img/Streak.png"),
            Text(
              "2",
              style: TextStyle(
                fontSize: 68,
                fontWeight: FontWeight.bold,
                color: Color(0XFFFF8700),
              ),
            ),
            Text("days streak", style: GoogleFonts.balsamiqSans(fontSize: 33)),
            SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
              decoration: BoxDecoration(
                color: const Color(
                  0xFFF1E5F8,
                ), // Matching the light purple/pink
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double itemWidth = constraints.maxWidth / 7;

                      return Column(
                        children: [
                          // Days Labels Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: days
                                .map(
                                  (day) => SizedBox(
                                    width: itemWidth,
                                    child: Text(
                                      day,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          SizedBox(height: 15),

                   
                          Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                             
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(
                                  7,
                                  (index) => Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.purple.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),

                              // The Orange Capsule Overlay
                              Container(
                                height: 38,
                                // Calculating width based on streak count
                                width: (itemWidth * streakCount),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.orange.withOpacity(0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: List.generate(
                                    streakCount,
                                    (index) => const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Let's move forward, giving up is not an option",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => Get.toNamed("/letBeginWithUs"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B13EC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Continue",
                  style: GoogleFonts.balsamiqSans(fontSize: 23,color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
