import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/selected_role_screen/select_role_screen_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

part 'select_role_screen_binding.dart';

// ── Design tokens ──────────────────────────────────────────────────────────
const _purple = Color(0xFF5B13EC);
const _purpleLight = Color(0xFFF3EEFF);
const _purpleSoft = Color(0xFFEDE4FF);
const _bg = Color(0xFFF7F4FF);
const _dark = Color(0xFF1A1A2E);
const _grey = Color(0xFF9B8AB8);

class SelectRoleScreenView extends GetView<SelectRoleScreenController> {
  const SelectRoleScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: _bg,
      body: Column(
        children: [
          _Header(screenH: screenH),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Section label ──────────────────────────────────
                  Text(
                    "I am a",
                    style: GoogleFonts.balsamiqSans(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: _grey,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Choose your role",
                    style: GoogleFonts.balsamiqSans(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _dark,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Role cards ─────────────────────────────────────
                  _RoleCard(
                    role: 'doctor',
                    icon: Icons.medical_services_outlined,
                    title: "Doctor",
                    subtitle: "Manage patients & consultations",
                    accentColor: const Color(0xFF12B76A),
                    accentBg: const Color(0xFFECFDF5),
                  ),
                  const SizedBox(height: 14),
                  _RoleCard(
                    role: 'user',
                    icon: Icons.favorite_border_rounded,
                    title: "Patient",
                    subtitle: "Track your wellness journey",
                    accentColor: _purple,
                    accentBg: _purpleSoft,
                  ),

                  const Spacer(),

                  // ── Continue button ────────────────────────────────
                  _ContinueButton(),
                  const SizedBox(height: 36),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Header ─────────────────────────────────────────────────────────────────
class _Header extends GetView<SelectRoleScreenController> {
  final double screenH;
  const _Header({required this.screenH});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenH * 0.38,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Purple blob background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF7B3FF5), Color(0xFF5B13EC)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
          ),

          // Decorative circle top-right
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.07),
              ),
            ),
          ),

          // Decorative circle bottom-left
          Positioned(
            bottom: 10,
            left: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),

          // Top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Setup Profile",
                      style: GoogleFonts.balsamiqSans(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 38), // balance
                  ],
                ),
              ),
            ),
          ),

          // Illustration
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Obx(() {
              final imagePath = controller.selectedRole.value == 'user'
                  ? 'assets/patient.png'
                  : 'assets/doctor.png';
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, anim) => FadeTransition(
                  opacity: anim,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.08),
                      end: Offset.zero,
                    ).animate(anim),
                    child: child,
                  ),
                ),
                child: Image.asset(
                  imagePath,
                  key: ValueKey(imagePath),
                  height: screenH * 0.26,
                  fit: BoxFit.contain,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ── Role card ───────────────────────────────────────────────────────────────
class _RoleCard extends GetView<SelectRoleScreenController> {
  final String role;
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accentColor;
  final Color accentBg;

  const _RoleCard({
    required this.role,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.accentBg,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedRole.value == role;

      return GestureDetector(
        onTap: () => controller.selectRole(role),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: isSelected ? _purpleLight : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? _purple : const Color(0xFFE8E0F7),
              width: isSelected ? 2 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? _purple.withOpacity(0.12)
                    : Colors.black.withOpacity(0.04),
                blurRadius: isSelected ? 16 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon badge
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: isSelected ? _purple.withOpacity(0.12) : accentBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  size: 26,
                  color: isSelected ? _purple : accentColor,
                ),
              ),
              const SizedBox(width: 14),

              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.balsamiqSans(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? _purple : _dark,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: GoogleFonts.balsamiqSans(
                        fontSize: 13,
                        color: _grey,
                      ),
                    ),
                  ],
                ),
              ),

              // Check indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? _purple : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? _purple : const Color(0xFFD0C8E8),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
            ],
          ),
        ),
      );
    });
  }
}

// ── Continue button ─────────────────────────────────────────────────────────
class _ContinueButton extends GetView<SelectRoleScreenController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final enabled = controller.hasSelectedRole;
      return SizedBox(
        width: double.infinity,
        height: 56,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: enabled
                ? const LinearGradient(
                    colors: [Color(0xFF7B3FF5), Color(0xFF5B13EC)],
                  )
                : null,
            color: enabled ? null : const Color(0xFFE8E0F7),
            boxShadow: enabled
                ? [
                    BoxShadow(
                      color: _purple.withOpacity(0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: ElevatedButton(
            onPressed: enabled ? controller.onContinue : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              disabledBackgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Continue",
                  style: GoogleFonts.balsamiqSans(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: enabled ? Colors.white : _grey,
                  ),
                ),
                if (enabled) ...[
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    });
  }
}