import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:flutter_application_1/app/shared/themes/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

part 'real_screen_controller.dart';

class RealScreenView extends GetView<RealScreenViewController> {
  const RealScreenView({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
  backgroundColor: AppColors.primary,
  body: 
    Stack(
        children: [
          Positioned.fill(
            child: _buildHeader(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 25,
            child: _buildBottomNavigation(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/reels.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. Tung Tung Sahur',
                          style: GoogleFonts.balsamiqSans(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Why u need to keep living? try this...',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.balsamiqSans(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.searchReelsScreen);
                    },
                    child: Image.asset(
                      'assets/img/search-normal.png',
                      width: 40,
                      height: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    final List<Map<String, dynamic>> navItems = [
      {"image": "assets/buttom_nav_icons/home.png", "label": "Home"},
      {"image": "assets/buttom_nav_icons/chart-success.png", "label": "Chat"},
      {"image": "assets/buttom_nav_icons/video-play.png", "label": "Video"},
      {"image": "assets/buttom_nav_icons/profile.png", "label": "Profile"},
    ];

    return Container(
      height: 70,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 12 , vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE5E5),
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