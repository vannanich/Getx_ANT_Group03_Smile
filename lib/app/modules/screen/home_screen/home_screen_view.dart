import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/chat_ai_screen/chat_ai_screen_controller.dart';
import 'package:flutter_application_1/app/modules/screen/chat_ai_screen/chat_ai_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/chat_with_doctor/chat_with_doctor_controller.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/chat_with_doctor/chat_with_doctor_view.dart';
import 'package:flutter_application_1/app/modules/screen/home_screen/home_screen_controller.dart';
import 'package:flutter_application_1/app/modules/screen/mood_screen/mood_screen/mood_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/profile_screen/profile_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/quote_screen/quote_screen/quote_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/readbookscreen/read_book_screen/read_book_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/real_screen/search_screen/search_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/sleeping_mood/sleeping_mood_controller.dart';
import 'package:flutter_application_1/app/modules/screen/sleeping_mood/sleeping_mood_view.dart';
import 'package:flutter_application_1/app/modules/screen/video_screen/video_screen_view.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



class HomeScreenView extends GetView<HomeScreenController> {
   HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
  children: [
    PageView(
      controller: controller.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        // index 0 - Home (your existing content)
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 25),
              _buildslidstack(),
              SizedBox(height: 30),
              _buildGridMenu(),
            ],
          ),
        ),
        // index 1 - Chat
      Builder(
        builder: (context) {
          Get.lazyPut(() => ChatWithDoctorController());
          return ChatWithDoctorView();
        },
      ),
        SearchScreenView(),
        ProfileScreenView(),
      ],
    ),
    Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: _buildBottomNavigation(),
    ),
  ],
),
      ),
    );
  }

  Widget _buildHeader() {
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
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "Scott",
                    style: GoogleFonts.balsamiqSans(
                      fontSize: 21,
                      color: Colors.black,
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
        color: color.withOpacity(0.1), // Light purple background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  Widget _buildslidstack() {
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.all(5),
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
                // Top Left Text
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
          padding:  EdgeInsets.all(5),
          child: Container(
            width: 800,
            height: 100,
            padding:  EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color:  Color.fromARGB(96, 208, 240, 210),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                // Left Icon Box
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(122, 148, 243, 161),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(
                    "assets/doctor.png",
                    color: Colors.brown.shade400,
                  ),
                ),
                SizedBox(width: 15),
                // Text
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
                            color: Colors.brown.shade700,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Safe, trustworthy & professional",
                        style: GoogleFonts.balsamiqSans(
                          fontSize: 15,
                          color: Colors.brown.shade300,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.brown.shade400,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGridMenu() {
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
              () => AiChatView(),
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

        return GestureDetector(
          onTap: () => item["route"]?.call(),
          child: Container(
            decoration: BoxDecoration(
              color: (item["color"] as Color).withOpacity(0.12),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  item["image"] as String,
                  width: 45,
                  height: 45,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),
                Text(
                  item["title"] as String,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.balsamiqSans(
                    fontSize: 13,
                    color: item["color"] as Color,
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

  Widget _buildBottomNavigation() {
    final List<Map<String, dynamic>> navItems = [
      {"image": "assets/home.png", "label": "Home"},
      {"image": "assets/chart_success.png", "label": "Chat"},
      {"image": "assets/video-play.png", "label": "Reels"},
      {"image": "assets/profile.png", "label": "Profile"},
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
