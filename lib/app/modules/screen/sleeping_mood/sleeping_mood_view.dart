import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/sleeping_mood/sleeping_mood_controller.dart';
import 'package:flutter_application_1/app/shared/themes/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class SleepingmoodScreenView extends GetView<SleepingmoodScreenViewController> {
  
  const SleepingmoodScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          /// Background
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/img/sleepmode.png",
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  SizedBox(height: 40),
                  _buildTimerCard(),
                  SizedBox(height: 25),
                  _buildSoundsSection(),
                  SizedBox(height: 11),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.arrow_back,
                  size: 26, color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sleeping mode',
                style: GoogleFonts.balsamiqSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                'Have a goodnight sleep',
                style: GoogleFonts.balsamiqSans(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimerCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withOpacity(0.08),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Column(
        children: [
          Text(
            "Sleep Timer",
            style: GoogleFonts.balsamiqSans(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 15),
          Obx(() => Text(
                "${controller.pad(controller.hours.value)} : ${controller.pad(controller.minutes.value)} : ${controller.pad(controller.seconds.value)}",
                style: GoogleFonts.balsamiqSans(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
          SizedBox(height: 20),
          Obx(() => GestureDetector(
                onTap: controller.toggleTimer,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    gradient: LinearGradient(
                      colors: controller.isRunning.value
                          ? [const Color(0xFFFF6B6B), const Color(0xFFCC0000)]
                          : [const Color(0xFFE887FF), const Color(0xFFB200FF)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (controller.isRunning.value
                                ? const Color(0xFFCC0000)
                                : const Color(0xFFB200FF))
                            .withOpacity(0.4),
                        blurRadius: 15,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      controller.isRunning.value ? "Stop Timer" : "Start Timer",
                      style: GoogleFonts.balsamiqSans(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildSoundsSection() {
    final sounds = [
      {"title": "Typhoon",      "image": "assets/img/typhoon.png"},
      {"title": "Sleet",        "image": "assets/img/sleet.png"},
      {"title": "Heavenly Day", "image": "assets/img/Sunny.png"},
      {"title": "Snowy Winter", "image": "assets/img/snow.png"},
      {"title": "Cloudiness",   "image": "assets/img/cloudness.png"},
      {"title": "Desert Wind",  "image": "assets/img/Heavy Sandstorm.png"},
      {"title": "Starry Nights","image": "assets/img/Night.png"},
      {"title": "Tribal Drums", "image": "assets/img/durms.png"},
      {"title": "Medium Rain",  "image": "assets/img/Rain.png"},
      {"title": "Snowy Breeze", "image": "assets/img/Blowing-snow.png"},
      {"title": "Heavy Rain",   "image": "assets/img/Drizzle.png"},
      {"title": "Wind",         "image": "assets/img/Gale.png"},
      {"title": "Light Rain",   "image": "assets/img/Showers.png"},
      {"title": "Wind",         "image": "assets/img/Storm.png"},
      {"title": "Thunder",      "image": "assets/img/Thundershower.png"},
      {"title": "Tornado",      "image": "assets/img/Tornado.png"},
    ];

    // ── Gradient per item matching the screenshot ──
    final List<List<Color>> gradients = [
      [const Color(0xFF6B0080), const Color(0xFF2A0040)], // Typhoon
      [const Color(0xFF9D27FF), const Color(0xFF5500CC)], // Sleet
      [const Color(0xFF1A0030), const Color(0xFF0D001A)], // Heavenly Day
      [const Color(0xFF1A0030), const Color(0xFF0D001A)], // Snowy Winter
      [const Color(0xFF1A0030), const Color(0xFF0D001A)], // Cloudiness
      [const Color(0xFF7B00CC), const Color(0xFF3D0066)], // Desert Wind
      [const Color(0xFFE887FF), const Color(0xFF9D27FF)], // Starry Nights
      [const Color(0xFFE887FF), const Color(0xFF9D27FF)], // Tribal Drums
      [const Color(0xFF2A0040), const Color(0xFF0D001A)], // Medium Rain
      [const Color(0xFF1A0030), const Color(0xFF0D001A)], // Snowy Breeze
      [const Color(0xFF1A0030), const Color(0xFF0D001A)], // Heavy Rain
      [const Color(0xFF1A0030), const Color(0xFF0D001A)], // Wind
      [const Color(0xFF1A0030), const Color(0xFF0D001A)], // Light Rain
      [const Color(0xFF1A0030), const Color(0xFF0D001A)], // Wind
      [const Color(0xFF1A0030), const Color(0xFF0D001A)], // Thunder
      [const Color(0xFF1A0030), const Color(0xFF0D001A)], // Tornado
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sounds",
            style: GoogleFonts.balsamiqSans(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sounds.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 8,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final item = sounds[index];

              return Column(
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: gradients[index],
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.12),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: gradients[index][0].withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Image.asset(
                        item["image"] as String,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 68,
                    child: Text(
                      item["title"] as String,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.balsamiqSans(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}