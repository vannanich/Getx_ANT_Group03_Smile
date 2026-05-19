import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/selected_role_screen/select_role_screen_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

part 'select_role_screen_binding.dart';

class SelectRoleScreenView extends GetView<SelectRoleScreenController> {
  const SelectRoleScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          SizedBox(height: 20),
          _buildRoleCard(
            role: 'doctor',
            icon: Icons.medical_services_outlined,
            title: "Continue as a doctor",
            subtitle: "Be a doctor to comfort patient",
            defaultColor: Color.fromARGB(96, 208, 240, 210),
            defaultBorderColor: Colors.green.shade200,
          ),
          _buildRoleCard(
            role: 'user',
            icon: Icons.person_3_outlined,
            title: "Continue as a user",
            subtitle: "Your wellness journey starts here",
            defaultColor: Color(0xFFEBEBFF),
            defaultBorderColor: Color.fromARGB(255, 196, 196, 247),
          ),
          SizedBox(height: 60),
          _buildContinueButton(),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildRoleCard({
    required String role,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color defaultColor,
    required Color defaultBorderColor,
  }) {
    return Obx(() {
      final isSelected = controller.selectedRole.value == role;

      return GestureDetector(
        onTap: () => controller.selectRole(role),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: double.infinity,
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFFF3EEFF) : defaultColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? Color(0xFF5B13EC) : defaultBorderColor,
                width: isSelected ? 2.5 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Color(0xFF5B13EC).withOpacity(0.12),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      )
                    ]
                  : [],
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color(0xFF5B13EC).withOpacity(0.12)
                        : Color.fromARGB(132, 185, 240, 192),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    icon,
                    size: 30,
                    color: isSelected ? Color(0xFF5B13EC) : Colors.brown,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.balsamiqSans(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Color(0xFF5B13EC)
                                : Colors.brown.shade700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          subtitle,
                          style: GoogleFonts.balsamiqSans(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 200),
                  opacity: isSelected ? 1.0 : 0.0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Color(0xFF5B13EC),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check, size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildHeader(BuildContext context) {
  return Stack(
    children: [
      Container(color: const Color(0xFFF6D6E9)),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.50,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFFB57EDC),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(200),
              bottomRight: Radius.circular(200),
            ),
          ),
        ),
      ),
      Positioned(
        top: 65,
        left: 115,
        child: Obx(() {
          final imagePath = controller.selectedRole.value == 'user'
              ? 'assets/as_user.png'   
              : 'assets/as_doctor.png';

          return AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: Image.asset(
              imagePath,
              key: ValueKey(imagePath), // triggers animation on change
              width: 120,
              fit: BoxFit.cover,
            ),
          );
        }),
      ),
    ],
  );
}

  Widget _buildContinueButton() {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed:
                  controller.hasSelectedRole ? controller.onContinue : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B13EC),
                disabledBackgroundColor: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Continue",
                style: GoogleFonts.balsamiqSans(
                  fontSize: 23,
                  color:
                      controller.hasSelectedRole ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
        ));
  }
}