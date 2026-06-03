import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:get/get.dart';

part 'profile_screen_binding.dart';
part 'profile_screen_controller.dart';

class ProfileScreenView extends GetView<ProfileScreenViewController> {
  const ProfileScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEBF8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              // HEADER
              Stack(
                alignment: Alignment.center,
                children: [
                  // CENTER TEXT
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.editProfile);
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/edit.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFD166),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFFFD166).withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://www.shutterstock.com/shutterstock/photos/2368533593/display_1500/stock-photo-cute-profile-pictures-halloween-themed-2368533593.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              const Text(
                'Username',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D2D4E),
                ),
              ),

              const SizedBox(height: 24),

              // ARCHIVE CARD
              _buildCard(
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDFC6FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.bookmark,
                        color: Color(0xFF8046CA),
                        size: 25,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ARCHIVE',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF4B4B4B),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.0,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Saved Quotes',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4B4B4B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                bottom: const Text(
                  '10',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7C5CBF),
                  ),
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: _buildCard(
                      child: Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF48E),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/streak.png',
                                width: 28,
                                height: 28,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'ACTIVE',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF4B4B4B),
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Daily Streak',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF4B4B4B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      bottom: const Text(
                        '🔥 2 days',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF6B35),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildCard(
                      child: Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF1BA),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/clam.png',
                                width: 35,
                                height: 35,
                                color: const Color(0xFFFCD53F),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'STATUS',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF4B4B4B),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Calm',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF4B4B4B),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      bottom: const Text(
                        'Mood',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFC947),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // REFLECTIONS CARD
              _buildCard(
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3DAA7A),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.menu_book_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mood',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF4B4B4B),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.0,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'REFLECTIONS',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4B4B4B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                bottom: const Text(
                  '0',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3DAA7A),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child, Widget? bottom}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C5CBF).withValues(alpha: 0.06),
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
