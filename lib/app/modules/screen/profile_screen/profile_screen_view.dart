import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/core/themes/theme_controller.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:get/get.dart';

part 'profile_screen_binding.dart';
part 'profile_screen_controller.dart';

class ProfileScreenView extends GetView<ProfileScreenViewController> {
  const ProfileScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // ── Use GLOBAL theme controller instead of local ──────────────────────
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDark = themeController.isDarkMode.value;

      final bgColor     = isDark ? const Color(0xFF0F0E1A) : const Color(0xFFEEEBF8);
      final cardColor   = isDark ? const Color(0xFF1C1A2E) : Colors.white;
      final textPrimary = isDark ? Colors.white : const Color(0xFF2D2D4E);
      final textMid     = isDark ? Colors.white70 : const Color(0xFF4B4B4B);

      return AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        color: bgColor,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [

                  // ── HEADER ────────────────────────────────────────────────
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: textPrimary,
                        ),
                        child: const Text('Profile'),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // 🌙 / ☀️ toggle — now controls GLOBAL theme
                            GestureDetector(
                              onTap: () => themeController.toggleTheme(),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.1)
                                      : Colors.white.withValues(alpha: 0.6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween(
                                      begin: 0.0,
                                      end: isDark ? 1.0 : 0.0),
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                  builder: (_, value, __) {
                                    return Transform.rotate(
                                      angle: value * 3.14159,
                                      child: Icon(
                                        isDark
                                            ? Icons.light_mode_rounded
                                            : Icons.dark_mode_rounded,
                                        size: 20,
                                        color: isDark
                                            ? const Color(0xFFFFC947)
                                            : const Color(0xFF7C5CBF),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Edit button
                            GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.editProfile),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.1)
                                      : Colors.white.withValues(alpha: 0.6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Image.asset('assets/edit.png',
                                      width: 40, height: 40),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // ── AVATAR ───────────────────────────────────────────────
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFFD166),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFD166).withValues(alpha: 0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.network(
                        'https://www.shutterstock.com/shutterstock/photos/2368533593/display_1500/stock-photo-cute-profile-pictures-halloween-themed-2368533593.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                            Icons.person, size: 50, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                    ),
                    child: const Text('Username'),
                  ),

                  const SizedBox(height: 24),

                  // ── ARCHIVE CARD ──────────────────────────────────────────
                  _buildCard(
                    isDark: isDark,
                    cardColor: cardColor,
                    child: Row(
                      children: [
                        Container(
                          width: 52, height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDFC6FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.bookmark,
                              color: Color(0xFF8046CA), size: 25),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 400),
                              style: TextStyle(fontSize: 12, color: textMid,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.0),
                              child: const Text('ARCHIVE'),
                            ),
                            const SizedBox(height: 2),
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 400),
                              style: TextStyle(fontSize: 15,
                                  fontWeight: FontWeight.w600, color: textMid),
                              child: const Text('Saved Quotes'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    bottom: const Text('10',
                        style: TextStyle(fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7C5CBF))),
                  ),

                  const SizedBox(height: 20),

                  // ── STREAK + MOOD ROW ─────────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: _buildCard(
                          isDark: isDark,
                          cardColor: cardColor,
                          child: Row(
                            children: [
                              Container(
                                width: 52, height: 52,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF48E),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Image.asset('assets/streak.png',
                                      width: 28, height: 28),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnimatedDefaultTextStyle(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      style: TextStyle(
                                          fontSize: 12, color: textMid,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.0),
                                      child: const Text('ACTIVE'),
                                    ),
                                    const SizedBox(height: 4),
                                    AnimatedDefaultTextStyle(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      style: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: textMid),
                                      child: const Text('Daily Streak'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          bottom: const Text('🔥 2 days',
                              style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF6B35))),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildCard(
                          isDark: isDark,
                          cardColor: cardColor,
                          child: Row(
                            children: [
                              Container(
                                width: 52, height: 52,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF1BA),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Image.asset('assets/clam.png',
                                      width: 35, height: 35,
                                      color: const Color(0xFFFCD53F)),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedDefaultTextStyle(
                                    duration:
                                        const Duration(milliseconds: 400),
                                    style: TextStyle(fontSize: 12,
                                        color: textMid,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.0),
                                    child: const Text('STATUS'),
                                  ),
                                  const SizedBox(height: 2),
                                  AnimatedDefaultTextStyle(
                                    duration:
                                        const Duration(milliseconds: 400),
                                    style: TextStyle(fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: textMid),
                                    child: const Text('Calm'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          bottom: const Text('Mood',
                              style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFC947))),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // ── REFLECTIONS CARD ──────────────────────────────────────
                  _buildCard(
                    isDark: isDark,
                    cardColor: cardColor,
                    child: Row(
                      children: [
                        Container(
                          width: 42, height: 42,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3DAA7A),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.menu_book_rounded,
                              color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 400),
                              style: TextStyle(fontSize: 12, color: textMid,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.0),
                              child: const Text('Mood'),
                            ),
                            const SizedBox(height: 2),
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 400),
                              style: TextStyle(fontSize: 15,
                                  fontWeight: FontWeight.w700, color: textMid),
                              child: const Text('REFLECTIONS'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    bottom: const Text('0',
                        style: TextStyle(fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3DAA7A))),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCard({
    required Widget child,
    Widget? bottom,
    required bool isDark,
    required Color cardColor,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C5CBF)
                .withValues(alpha: isDark ? 0.15 : 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child,
          if (bottom != null) ...[
            const SizedBox(height: 10),
            bottom,
          ],
        ],
      ),
    );
  }
}