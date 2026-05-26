import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/chat_ai_screen/chat_ai_screen_controller.dart';
import 'package:flutter_application_1/app/modules/screen/chat_ai_screen/chat_ai_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/d_homescreen/d_homescreen_controller.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/scan_id/scan_doctor_id/scan_doctor_id_controller.dart';
import 'package:flutter_application_1/app/modules/screen/home_screen/home_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/mood_screen/mood_screen/mood_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/quote_screen/quote_screen/quote_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/readbookscreen/read_book_screen/read_book_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/sleeping_mood/sleeping_mood_view.dart';
import 'package:flutter_application_1/app/modules/screen/video_screen/video_screen_view.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:flutter_application_1/app/shared/themes/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class DHomescreenView extends GetView<DoctorHomeController> {
  const DHomescreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 35),
                _buildSlideStack(),
                const SizedBox(height: 35),
                _buildGridMenu(),
                const SizedBox(height: 20),
                _buildBottomNavigation(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 55, height: 55,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondary.withOpacity(0.12),
            border: Border.all(
                color: AppColors.secondary.withOpacity(0.25), width: 2),
          ),
          child: const Icon(Icons.person_rounded,
              color: AppColors.icons, size: 28),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning, keep Smiling',
                style: GoogleFonts.balsamiqSans(
                    fontSize: 16,
                    color: AppColors.secondary.withOpacity(0.6)),
              ),
              const SizedBox(height: 3),
              Text(
                'Scott',
                style: GoogleFonts.balsamiqSans(
                    fontSize: 21,
                    // color: AppColors.textDark,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        _buildHeaderIcon(Icons.qr_code_scanner_outlined),
        const SizedBox(width: 10),
        _buildHeaderIcon(Icons.notifications_active_outlined),
      ],
    );
  }

  Widget _buildHeaderIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: AppColors.icons, size: 24),
    );
  }

  // ── Banner + chat card ─────────────────────────────────────────────────────
  Widget _buildSlideStack() {
    return Column(
      children: [
        // Daily reminder banner
        Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            width: double.infinity, height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/bg_homescreen_card.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Color(0x66000000), BlendMode.darken),
              ),
            ),
            child: Stack(children: [
              Positioned(
                top: 35, left: 20,
                child: Text('Daily Reminder',
                    style: GoogleFonts.balsamiqSans(
                        fontSize: 20, color: Colors.white70)),
              ),
              Positioned(
                top: 70, left: 20,
                child: Text('You are enough,\njust as you are',
                    style: GoogleFonts.balsamiqSans(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        // color: AppColors.white
                        )),
              ),
            ]),
          ),
        ),
        const SizedBox(height: 15),
        // Chat with doctor card
        Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            width: double.infinity, height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.07),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: AppColors.secondary.withOpacity(0.18)),
            ),
            child: Row(children: [
              Container(
                width: 55, height: 55,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.medical_services_outlined,
                    size: 30, color: AppColors.icons),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.chatWithDoctor),
                      child: Text('Chat with Doctor',
                          style: GoogleFonts.balsamiqSans(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary)),
                    ),
                    const SizedBox(height: 5),
                    Text('Safe, trustworthy & professional',
                        style: GoogleFonts.balsamiqSans(
                            fontSize: 15,
                            color: AppColors.secondary.withOpacity(0.5))),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  size: 20,
                  color: AppColors.secondary.withOpacity(0.45)),
            ]),
          ),
        ),
      ],
    );
  }

  // ── Grid menu ──────────────────────────────────────────────────────────────
  Widget _buildGridMenu() {
    final List<Map<String, dynamic>> items = [
      {
        'icon': Icons.mood,
        'title': 'Track Mood',
        // 'color': AppColors.amber,
        'route': () => Get.to(() => MoodScreenView(),
            binding: BindingsBuilder(
                () => Get.lazyPut(() => MoodScreenController()))),
      },
      {
        'icon': Icons.menu_book_rounded,
        'title': 'Read Book',
        'color': const Color(0xFF2980B9),
        'route': () => Get.to(() => ReadBookScreenView(),
            binding: BindingsBuilder(
                () => Get.lazyPut(() => ReadBookScreenController()))),
      },
      {
        'icon': Icons.psychology_alt,
        'title': 'Chat AI',
        'color': AppColors.secondary,
        'route': () => Get.to(() => AiChatView(),
            binding: BindingsBuilder(
                () => Get.lazyPut(() => AiChatController()))),
      },
      {
        'icon': Icons.format_quote_rounded,
        'title': 'Read Quotes',
        // 'color': AppColors.pink,
        'route': () => Get.to(() => QuoteScreenView(),
            binding: BindingsBuilder(
                () => Get.lazyPut(() => QuoteScreenController()))),
      },
      {
        'icon': Icons.play_circle_filled_rounded,
        'title': 'Watch Videos',
        // 'color': AppColors.red,
        'route': () => Get.to(() => VideoScreenView(),
            binding: BindingsBuilder(
                () => Get.lazyPut(() => VideoScreenViewController()))),
      },
      {
        'icon': Icons.nightlight_round,
        'title': 'Sleeping Mode',
        'color': const Color(0xFF6C3483),
        'route': () => Get.to(() => SleepModeView(),
            binding: BindingsBuilder(
                () => Get.lazyPut(() => ScanDoctorIdController()))),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        final Color c = item['color'] as Color;
        return GestureDetector(
          onTap: () => (item['route'] as VoidCallback?)?.call(),
          child: Container(
            decoration: BoxDecoration(
              color: c.withOpacity(0.1),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: c.withOpacity(0.18)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item['icon'] as IconData, size: 47, color: c),
                const SizedBox(height: 12),
                Text(
                  item['title'] as String,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.balsamiqSans(
                      fontSize: 15,
                      color: c,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ── Bottom navigation ──────────────────────────────────────────────────────
  // 4 tabs that mirror the most-used grid items:
  //   Home · Mood · Videos · Profile
  Widget _buildBottomNavigation() {
    return Container(
      height: 70,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.07),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.secondary.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
              color: AppColors.secondary.withOpacity(0.08),
              blurRadius: 10),
        ],
      ),
      child: GNav(
        textStyle: GoogleFonts.balsamiqSans(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.secondary,
        ),
        rippleColor: Colors.transparent,
        hoverColor: Colors.transparent,
        haptic: true,
        tabBorderRadius: 20,
        curve: Curves.easeOutExpo,
        duration: const Duration(milliseconds: 300),
        gap: 8,
        color: AppColors.secondary.withOpacity(0.4),
        activeColor: AppColors.secondary,
        iconSize: 24,
        tabBackgroundColor: AppColors.secondary.withOpacity(0.12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        selectedIndex: 0,
        onTabChange: (index) => debugPrint('Tab: $index'),
        tabs: const [
          GButton(icon: Icons.home_rounded,               text: 'Home'),
          GButton(icon: Icons.mood,                       text: 'Mood'),
          GButton(icon: Icons.play_circle_filled_rounded, text: 'Videos'),
          GButton(icon: Icons.person_rounded,             text: 'Profile'),
        ],
      ),
    );
  }
}