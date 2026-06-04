// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/shared/themes/app_colors.dart';
import 'package:get/get.dart';

part 'mood_screen_binding.dart';
part 'mood_screen_controller.dart';

class MoodScreenView extends GetView<MoodScreenController> {
  const MoodScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMoodGrid(),
                    SizedBox(height: 5),
                    _buildLogButton(),
                    SizedBox(height: 5),
                    _buildThisWeekSection(),
                    _buildStatsRow(),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child:
                Icon(Icons.arrow_back_ios, size: 20, color: Color(0xFF2E2C35)),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Track Your Mood",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2E2C35),
              ),
            ),
            Text(
              "How are you feeling right now?",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9F9DA4),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMoodGrid() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.moods.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemBuilder: (_, i) => _buildMoodCard(i),
      ),
    );
  }

  Widget _buildMoodCard(int index) {
    final mood = controller.moods[index];
    return Obx(() {
      final isSelected = controller.isSelected(index);
      return GestureDetector(
        onTap: () => controller.selectMood(index),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isSelected ? mood.selectedColor : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? mood.selectedBorder : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? mood.selectedBorder.withOpacity(0.2)
                    : Colors.black.withOpacity(0.04),
                blurRadius: isSelected ? 14 : 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: isSelected ? 1.2 : 1.0,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeOutBack,
                child: Text(mood.emoji, style: TextStyle(fontSize: 34)),
              ),
              SizedBox(height: 8),
              Text(
                mood.label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? mood.selectedBorder : Color(0xFF9F9DA4),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildLogButton() {
    return Obx(() {
      final saving = controller.isSaving.value;
      final active = controller.hasSelection;
      return Padding(
        padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: GestureDetector(
          onTap: controller.saveMood,
          child: AnimatedOpacity(
            opacity: active ? 1.0 : 0.5,
            duration: Duration(milliseconds: 200),
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Color(0xFF5B4FE9),
                borderRadius: BorderRadius.circular(18),
                boxShadow: active
                    ? [
                        BoxShadow(
                          color: Color(0xFF5B4FE9).withOpacity(0.35),
                          blurRadius: 16,
                          offset: Offset(0, 6),
                        ),
                      ]
                    : [],
              ),
              alignment: Alignment.center,
              child: saving
                  ? SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text(
                      "Log Mood",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildThisWeekSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "This Week",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2E2C35),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  controller.weekData.map((d) => _buildDayBar(d)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayBar(WeekDay day) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(day.emoji, style: TextStyle(fontSize: 18)),
        SizedBox(height: 6),
        Container(
          width: 36,
          height: day.heightFraction * 90,
          decoration: BoxDecoration(
            color: day.barColor,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(height: 8),
        Text(
          day.label,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF9F9DA4),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Row(
        children: [
          _buildStatCard('😊', 'Current Mood', flex: 1),
          SizedBox(width: 12),
          _buildStatCard('7', 'Day Streak', flex: 1),
          SizedBox(width: 12),
          _buildStatCard('85%', 'Positive', flex: 1),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, {required int flex}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2E2C35),
              ),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF9F9DA4),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
