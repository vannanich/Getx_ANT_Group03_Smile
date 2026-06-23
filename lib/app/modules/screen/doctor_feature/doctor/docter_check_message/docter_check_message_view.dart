import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/doctor/chat_with_patient_screen/chat_with_patient_screen_view.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

part 'docter_check_message_binding.dart';
part 'docter_check_message_controller.dart';

class DocterCheckMessageView extends StatefulWidget {
  const DocterCheckMessageView({super.key});

  @override
  State<DocterCheckMessageView> createState() => _DocterCheckMessageViewState();
}

class _DocterCheckMessageViewState extends State<DocterCheckMessageView> {
  final DocterCheckMessageViewController controller = Get.find();

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
              SizedBox(
                height: 510,
                child: _buildPatientList(),
              ),
              SizedBox(height: 25),
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
            Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr.Latte!!",
                      style: GoogleFonts.balsamiqSans(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Check your message",
                      style: GoogleFonts.balsamiqSans(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Spacer(),
        Stack(children: [
          Image.asset("assets/img/Patients.png"),
          Positioned(
            bottom: 3,
            left: 40,
            child: Image.asset("assets/img/Smartphone.png"),
          ),
          Positioned(
            bottom: 3,
            left: 30,
            child: Image.asset("assets/img/girl.png"),
          ),
          Positioned(
            bottom: 3,
            left: 70,
            child: Image.asset("assets/img/boy.png"),
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
      itemCount: patients.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
      final patient = patients[index];
      final unread = patient["unread"] ?? 0;
      final hasUnread = unread > 0;

    return GestureDetector(
               onTap: () => controller.openChat(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF5F5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(patient["image"]),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(patient["name"]),
                        const SizedBox(height: 4),
                        Text(
                          patient["lastMessage"] ?? "",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (hasUnread)
                        Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(
                            color: Color(0xff5B13EC),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "$unread",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      else
                        const SizedBox(height: 22),

                      const SizedBox(height: 4),

                      Text(
                        patient["time"] ?? "",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFFFE5E5),
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
