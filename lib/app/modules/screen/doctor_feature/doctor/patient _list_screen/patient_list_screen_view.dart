import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/doctor/chat_with_patient_screen/chat_with_patient_screen_view.dart';
import 'package:flutter_application_1/app/shared/themes/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

part 'patient_list_screen_binding.dart';
part 'patient_list_screen_controller.dart';

class PatientListScreenView extends GetView<PatientListScreenViewController> {
  const PatientListScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 25),
              _buildButtonSearch(),
              SizedBox(height: 25),
              Expanded(child: _buildPatientList()),
              SizedBox(height: 10),
              if (MediaQuery.of(context).viewInsets.bottom == 0)
              _buildBottomNavigation(),
          
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Morning, Dr.Latte!!",
              style: GoogleFonts.balsamiqSans(
                color: Colors.grey,
                fontSize: 17,
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  "You have ",
                  style: GoogleFonts.balsamiqSans(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                SizedBox(width: 3),
                Text(
                  "11 Patients",
                  style: GoogleFonts.balsamiqSans(
                    color: Color(0xff5B13EC),
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              "in totals",
              style: GoogleFonts.balsamiqSans(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ],
        ),
        Spacer(),
        Stack(children: [
          Image.asset("assets/img/Patients.png"),
          Positioned(
            bottom: 3,
            left: 45,
            child: Image.asset("assets/img/people_sick.png"),
          ),
        ]),
      ],
    );
  }

  Widget _buildButtonSearch() {
  return Row(
    children: [
        // Search TextField
      Expanded(
          child: TextField(
            controller: controller.searchController,
            onChanged: controller.searchPatient,
            decoration: InputDecoration(
              hintText: "Search patient...",
              hintStyle: GoogleFonts.balsamiqSans(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Purple Search Button
        SizedBox(
          height: 55,
          width: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff5B13EC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.zero,
            ),
            onPressed: () {
              // handle search
            },
            child: const Icon(Icons.search, color: Colors.white, size: 26),
          ),
        ),
      ],
    );
  }

  Widget _buildPatientList() {
    return Obx(() {
      final patients = controller.filteredPatients;

      return ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 10),
        itemCount: patients.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF5F5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage(
                    patients[index]["image"]!,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    patients[index]["name"]!,
                    style: GoogleFonts.balsamiqSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                width: 46,
                height: 46,
                decoration: const BoxDecoration(
                  color: Color(0xFFF4E8E8),
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(23),
                  onTap: () {
                    Get.to(
                      () => ChatWithPatientScreenView(
                        patientName: patients[index]["name"]!,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      "assets/img/message.png",
                    ),
                  ),
                ),
              ),
              ],
            ),
          );
        },
      );
    });
  }
  
  Widget _buildBottomNavigation() {
    final List<Map<String, dynamic>> navItems = [
      {"image": "assets/img/home.png", "label": "Home"},
        {"image": "assets/img/profile_patients.png", "label": "Patients"},
      {"image": "assets/img/message.png", "label": "Chat"},
      {"image": "assets/img/profile.png", "label": "Profile"},
    ];

    return Container(
      height: 70,
      margin:  EdgeInsets.all(10),
      padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color:  Color(0xFFFFE5E5),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(navItems.length, (index) {
            final isActive = controller.selectedIndex.value == index;

            return GestureDetector(
              onTap: () => controller.changeTab(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(
                  horizontal: isActive ? 20 : 12,
                  vertical: isActive ? 14 : 10,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.purple.withOpacity(0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedScale(
                      duration: const Duration(milliseconds: 300),
                      scale: isActive ? 1.1 : 1.0,
                      child: Image.asset(
                        navItems[index]["image"],
                        width: 24,
                        height: 24,
                        color: isActive ? Colors.purple : Colors.grey.shade600,
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SizeTransition(
                            sizeFactor: animation,
                            axis: Axis.horizontal,
                            child: child,
                          ),
                        );
                      },
                      child: isActive
                          ? Padding(
                              key: ValueKey(index),
                              padding: const EdgeInsets.only(left: 8),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  navItems[index]["label"],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.balsamiqSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.purple,
                                    height: 1,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}














































































































































// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// part 'patient_list_screen_binding.dart';
// part 'patient_list_screen_controller.dart';

// class PatientListScreenView extends GetView<PatientListScreenViewController> {
//   const PatientListScreenView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             children: [
//               _buildHeader(),
//               SizedBox(height: 25),
//               _buildButtonSearch(),
//               SizedBox(height: 25),
//               SizedBox(
//               height: 510,
//               child: _buildPatientList(),
//             ),
//              SizedBox(height: 25),
//               Spacer(),
//               _buildBottomNavigation(),

            
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Row(
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Good Morning, Dr.Latte!!",
//               style: GoogleFonts.balsamiqSans(
//                 color: Colors.grey,
//                 fontSize: 15,
//               ),
//             ),
//             SizedBox(height: 5),
//             Row(
//               children: [
//                 Text(
//                   "You have ",
//                   style: GoogleFonts.balsamiqSans(
//                     color: Colors.black,
//                     fontSize: 15,
//                   ),
//                 ),
//                 SizedBox(width: 3),
//                 Text(
//                   "11 Patients",
//                   style: GoogleFonts.balsamiqSans(
//                     color: Color(0xff5B13EC),
//                     fontSize: 15,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 5),
//             Text(
//               "in totals",
//               style: GoogleFonts.balsamiqSans(
//                 color: Colors.black,
//                 fontSize: 15,
//               ),
//             ),
//           ],
//         ),
//         Spacer(),
//         Stack(children: [
//           Image.asset("assets/img/Patients.png"),
//           Positioned(
//             bottom: 3,
//             left: 45,
//             child: Image.asset("assets/img/people_sick.png"),
//           ),
//         ]),
//       ],
//     );
//   }

//   Widget _buildButtonSearch() {
//   return Row(
//     children: [
//         // Search TextField
//       Expanded(
//           child: TextField(
//             decoration: InputDecoration(
//               hintText: "Search patient...",
//               hintStyle: GoogleFonts.balsamiqSans(color: Colors.grey),
//               filled: true,
//               fillColor: Colors.grey.shade100,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: BorderSide(color: Colors.grey.shade200),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide(color: Colors.grey.shade200),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide(color: Colors.grey.shade300),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(width: 10),

//         // Purple Search Button
//         SizedBox(
//           height: 55,
//           width: 55,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xff5B13EC),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               padding: EdgeInsets.zero,
//             ),
//             onPressed: () {
//               // handle search
//             },
//             child: const Icon(Icons.search, color: Colors.white, size: 26),
//           ),
//         ),
//       ],
//     );
//   }

//  Widget _buildPatientList() {
//   final patients = [
//     {
//       "name": "Arlene McCoy",
//       "image": "assets/img/pro1.jpg",
//     },
//     {
//       "name": "Darrell Steward",
//       "image": "assets/img/pro2.jpg",
//     },
//     {
//       "name": "Devon Lane",
//       "image": "assets/img/pro3.jpg",
//     },
//     {
//       "name": "Cameron Williamson",
//       "image": "assets/img/pro4.jpg",
//     },
//     {
//       "name": "Ralph Edwards",
//       "image": "assets/img/pro5.jpg",
//     },
//     {
//       "name": "Floyd Miles",
//       "image": "assets/img/pro6.jpg",
//     },
//     {
//       "name": "Brooklyn Simmons",
//       "image": "assets/img/pro7.jpg",
//     },
//     {
//       "name": "Jacob Jones",
//       "image": "assets/img/pro8.jpg",
//     },
//   ];

//   return ListView.separated(
//     physics: const BouncingScrollPhysics(),
//     padding: const EdgeInsets.only(bottom: 10),
//     itemCount: patients.length,
//     separatorBuilder: (_, __) => const SizedBox(height: 12),
//     itemBuilder: (context, index) {
//       return Container(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 14,
//           vertical: 12,
//         ),
//         decoration: BoxDecoration(
//           color: const Color(0xFFFFF5F5),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 28,
//               backgroundImage: AssetImage(
//                 patients[index]["image"]!,
//               ),
//             ),

//             const SizedBox(width: 14),

//             Expanded(
//               child: Text(
//                 patients[index]["name"]!,
//                 style: GoogleFonts.balsamiqSans(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),

//             Container(
//               width: 46,
//               height: 46,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF4E8E8),
//                 shape: BoxShape.circle,
//               ),
//               child: GestureDetector(
//                 onTap: () {
                  
//                 },
//                 child: Image.asset("assets/img/message.png"),

//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
  
//   Widget _buildBottomNavigation() {
//     final List<Map<String, dynamic>> navItems = [
//       {"image": "assets/img/home.png", "label": "Home"},
//       {"image": "assets/img/chart_success.png", "label": "Chat"},
//       {"image": "assets/img/video-play.png", "label": "Video"},
//       {"image": "assets/img/profile.png", "label": "Profile"},
//     ];

//     return Container(
//       height: 70,
//       margin:  EdgeInsets.all(10),
//       padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color:  Color(0xFFFFE5E5),
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Obx(
//         () => Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: List.generate(navItems.length, (index) {
//             final isActive = controller.selectedIndex.value == index;

//             return GestureDetector(
//               onTap: () => controller.changeTab(index),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 350),
//                 curve: Curves.easeInOut,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: isActive ? 20 : 12,
//                   vertical: isActive ? 14 : 10,
//                 ),
//                 decoration: BoxDecoration(
//                   color: isActive
//                       ? Colors.purple.withOpacity(0.15)
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     AnimatedScale(
//                       duration: const Duration(milliseconds: 300),
//                       scale: isActive ? 1.1 : 1.0,
//                       child: Image.asset(
//                         navItems[index]["image"],
//                         width: 24,
//                         height: 24,
//                         color: isActive ? Colors.purple : Colors.grey.shade600,
//                       ),
//                     ),
//                     AnimatedSwitcher(
//                       duration: const Duration(milliseconds: 250),
//                       transitionBuilder: (child, animation) {
//                         return FadeTransition(
//                           opacity: animation,
//                           child: SizeTransition(
//                             sizeFactor: animation,
//                             axis: Axis.horizontal,
//                             child: child,
//                           ),
//                         );
//                       },
//                       child: isActive
//                           ? Padding(
//                               key: ValueKey(index),
//                               padding: const EdgeInsets.only(left: 8),
//                               child: Align(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   navItems[index]["label"],
//                                   textAlign: TextAlign.center,
//                                   style: GoogleFonts.balsamiqSans(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w700,
//                                     color: Colors.purple,
//                                     height: 1,
//                                   ),
//                                 ),
//                               ),
//                             )
//                           : const SizedBox.shrink(),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }