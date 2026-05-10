import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/mood_screen/mood_screen/mood_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/quote_screen/quote_screen/quote_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/readbookscreen/read_book_screen/read_book_screen_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

part 'home_screen_binding.dart';
part 'home_screen_controller.dart';

class HomeScreenView extends GetView<HomeScreenViewController> {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _buildHeader(),
                SizedBox(height: 35),
                _buildslidstack(),
                SizedBox(height: 35),
                _buildGridMenu(),
                SizedBox(height: 20),
                _buildBottomNavigation(),
              ],
            ),
          ),
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
              width: 65,
              height: 65,
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
            _buildHeaderIcon(Icons.qr_code_scanner_outlined, Color(0xFF8E66F9)),
            SizedBox(width: 10),
            _buildHeaderIcon(
              Icons.notifications_active_outlined,
              Color(0xFF8E66F9),
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
          padding: const EdgeInsets.all(5),
          child: Container(
            width: 800,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage("assets/bg_homescreen_card.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  const Color.fromARGB(0, 160, 157, 157).withOpacity(0.4),
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
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 20,
                  child: Text(
                    "You are enough,\njust as you are",
                    style: GoogleFonts.balsamiqSans(
                      fontSize: 23,
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
          padding: const EdgeInsets.all(5),
          child: Container(
            width: 800,
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(96, 208, 240, 210),
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
                    color: const Color(0xFFD8CFC7),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.medical_services_outlined,
                    size: 30,
                    color: Colors.brown,
                  ),
                ),
                SizedBox(width: 15),
                // Text
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Chat with Doctor",
                        style: GoogleFonts.balsamiqSans(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade700,
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
        "icon": Icons.mood,
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
        "icon": Icons.menu_book_rounded,
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
        "icon": Icons.psychology_alt,
        "title": "Chat AI",
        "color": Colors.purple,
      },
      {
        "icon": Icons.forum_outlined,
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
        "icon": Icons.movie_creation_outlined,
        "title": "Watch Videos",
        "color": Colors.red,
      },
      {
        "icon": Icons.nightlight_round,
        "title": "Sleeping Mode",
        "color": Colors.deepPurple,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
              color: item["color"].withOpacity(0.12),
              borderRadius: BorderRadius.circular(22),
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item["icon"], size: 47, color: item["color"]),

                SizedBox(height: 12),

                Text(
                  item["title"],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.balsamiqSans(
                    fontSize: 15,
                    color: item["color"],
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
    return Container(
      height: 70,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE5E5),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: GNav(
        textStyle: GoogleFonts.balsamiqSans(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.purple,
        ),

        rippleColor: Colors.transparent,
        hoverColor: Colors.transparent,
        haptic: true,

        tabBorderRadius: 20,

        curve: Curves.easeOutExpo,
        duration: const Duration(milliseconds: 300),

        gap: 8,
        color: Colors.grey,
        activeColor: Colors.purple,
        iconSize: 24,

        tabBackgroundColor: Colors.purple.withOpacity(0.12),

        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

        selectedIndex: 0,

        onTabChange: (index) {
          print("Selected tab: $index");
        },

        tabs: const [
          GButton(icon: LineIcons.home, text: 'Home'),
          GButton(icon: LineIcons.facebookMessenger, text: 'Likes'),
          GButton(icon: LineIcons.video, text: 'Search'),
          GButton(icon: LineIcons.user, text: 'Profile'),
        ],
      ),
    );
  }
}
