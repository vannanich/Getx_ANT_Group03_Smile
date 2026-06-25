import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/core/themes/theme_controller.dart';
import 'package:flutter_application_1/app/modules/screen/chat_ai_screen/chat_ai_screen_controller.dart';
import 'package:flutter_application_1/app/modules/screen/chat_ai_screen/chat_ai_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/User/book_appointment/chat_with_doctor/chat_with_doctor_controller.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/User/book_appointment/chat_with_doctor/chat_with_doctor_view.dart';
import 'package:flutter_application_1/app/modules/screen/goal_screen/goal_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/home_screen/home_screen_controller.dart';
import 'package:flutter_application_1/app/modules/screen/mood_screen/mood_screen/mood_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/profile_screen/profile_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/quote_screen/quote_screen/quote_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/readbookscreen/read_book_screen/read_book_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/real_screen/real_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/sleeping_mood/sleeping_mood_controller.dart';
import 'package:flutter_application_1/app/modules/screen/sleeping_mood/sleeping_mood_view.dart';
import 'package:flutter_application_1/app/modules/screen/video_screen/video_screen_view.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenView extends GetView<HomeScreenController> {
   HomeScreenView({super.key});

  final ThemeController _theme = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = _theme.isDarkMode.value;

      return Scaffold(
        backgroundColor: isDark ? const Color(0xFF0F0E1A) : Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              PageView(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        _buildHeader(isDark),
                        SizedBox(height: 25),
                        _buildslidstack(isDark),
                        SizedBox(height: 30),
                        _buildGridMenu(isDark),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      Get.lazyPut(() => GoalScreenController());
                      return GoalScreenView();
                    },
                  ),
                  Builder(
                    builder: (context) {
                      Get.lazyPut(() => RealScreenViewController());
                      return RealScreenView();
                    },
                  ),
                  Builder(
                    builder: (context) {
                      Get.lazyPut(() => ProfileScreenViewController());
                      return ProfileScreenView();
                    },
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildBottomNavigation(isDark),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildHeader(bool isDark) {
    return Column(
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
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good morning keep Smiling",
                    style: GoogleFonts.balsamiqSans(
                      fontSize: 16,
                      color: isDark ? Colors.white60 : Colors.grey,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "Scott",
                    style: GoogleFonts.balsamiqSans(
                      fontSize: 21,
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.scanFaceScreen);
              },
              child: _buildHeaderIcon(Icons.qr_code_scanner_outlined, Color(0xFF8E66F9))),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.notificationScreen);
              },
              child: _buildHeaderIcon(
                Icons.notifications_active_outlined,
                Color(0xFF8E66F9),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderIcon(IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  Widget _buildslidstack(bool isDark) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            width: 800,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage("assets/bg_homescreen_card.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  const Color.fromARGB(0, 179, 176, 176).withOpacity(0.4),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 35,
                  left: 20,
                  child: Text(
                    "Dialy Reminder",
                    style: GoogleFonts.balsamiqSans(
                      fontSize: 19,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Positioned(
                  top: 73,
                  left: 20,
                  child: Text(
                    "You are enough,\njust as you are",
                    style: GoogleFonts.balsamiqSans(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            width: 800,
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF1A2A1F)
                  : Color.fromARGB(96, 208, 240, 210),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark
                    ? Colors.green.shade800.withOpacity(0.5)
                    : Colors.green.shade200,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.green.withOpacity(0.15)
                        : const Color.fromARGB(122, 148, 243, 161),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(
                    "assets/doctor.png",
                    color: isDark ? Colors.green.shade400 : Colors.brown.shade400,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.chatWithDoctor),
                        child: Text(
                          "Chat with Doctor",
                          style: GoogleFonts.balsamiqSans(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? Colors.green.shade300
                                : Colors.brown.shade700,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Safe, trustworthy & professional",
                        style: GoogleFonts.balsamiqSans(
                          fontSize: 15,
                          color: isDark
                              ? Colors.green.shade700
                              : Colors.brown.shade300,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: isDark ? Colors.green.shade400 : Colors.brown.shade400,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGridMenu(bool isDark) {
    final List<Map<String, dynamic>> items = [
      {
        "image": "assets/emoji_square.png",
        "title": "Track Mood",
        "color": Colors.orange,
        "route": () => Get.to(
              () => MoodScreenView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => MoodScreenController());
              }),
            ),
      },
      {
        "image": "assets/book.png",
        "title": "Read Book",
        "color": Colors.blue,
        "route": () => Get.to(
              () => ReadBookScreenView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => ReadBookScreenController());
              }),
            ),
      },
      {
        "image": "assets/ai_solid.png",
        "title": "Chat AI",
        "color": Colors.purple,
        "route": () => Get.to(
              () => ChatAiScreenView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => AiChatController());
              }),
            ),
      },
      {
        "image": "assets/quote.png",
        "title": "Read Quotes",
        "color": Colors.pink,
        "route": () => Get.to(
              () => QuoteScreenView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => QuoteScreenController());
              }),
            ),
      },
      {
        "image": "assets/video_frame.png",
        "title": "Watch Videos",
        "color": Colors.red,
        "route": () => Get.to(
              () => VideoScreenView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => VideoScreenViewController());
              }),
            ),
      },
      {
        "image": "assets/moon_stars.png",
        "title": "Sleeping Mode",
        "color": Colors.deepPurple,
        "route": () => Get.to(
              () => SleepingmoodScreenView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => SleepingmoodScreenViewController());
              }),
            ),
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
        final color = item["color"] as Color;

        return GestureDetector(
          onTap: () => item["route"]?.call(),
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? color.withOpacity(0.15)
                  : color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(22),
              border: isDark
                  ? Border.all(color: color.withOpacity(0.2), width: 1)
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  item["image"] as String,
                  width: 45,
                  height: 45,
                  fit: BoxFit.contain,
                  color: isDark ? color.withOpacity(0.85) : null,
                ),
                const SizedBox(height: 12),
                Text(
                  item["title"] as String,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.balsamiqSans(
                    fontSize: 13,
                    color: isDark ? color.withOpacity(0.85) : color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigation(bool isDark) {
    final List<Map<String, dynamic>> navItems = [
      {"image": "assets/home.png", "label": "Home"},
      {"image": "assets/chart_success.png", "label": "Goals"},
      {"image": "assets/video-play.png", "label": "Reels"},
      {"image": "assets/profile.png", "label": "Profile"},
    ];

    return Container(
      height: 70,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1A2E) : const Color(0xFFFFE5E5),
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
                        color: isActive
                            ? Colors.purple
                            : isDark
                                ? Colors.white54
                                : Colors.grey.shade600,
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