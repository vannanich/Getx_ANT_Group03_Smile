// ignore_for_file: unnecessary_string_interpolations, deprecated_member_use

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/core/themes/theme_controller.dart';
import 'package:get/get.dart';

import '../notification_screen/notification_screen_view.dart';

part 'notification_detail_binding.dart';
part 'notification_detail_controller.dart';

class NotificationDetailScreenView
    extends GetView<NotificationDetailViewController> {
  const NotificationDetailScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Get.find<ThemeController>().isDarkMode.value;
    final DateTime date = controller.notif.appointmentDate ?? DateTime.now();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F0E1A) : const Color(0xFFEEECF5),
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF0F0E1A) : const Color(0xFFEEECF5),
        toolbarHeight: 70,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notification",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black)),
            SizedBox(height: 4),
            Text("Review your notification",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF9F9DA4))),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNotificationCard(isDark),
            SizedBox(height: 24),
            _buildDateSection(date, isDark),
            SizedBox(height: 24),
            _buildClock(isDark),
            SizedBox(height: 24),
            _buildLocation(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(bool isDark) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1A2E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0F0E1A) : const Color(0xFFEEECF5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              controller.notif.icon == Icons.chat_bubble_outline
                  ? "assets/message.png"
                  : "assets/notif.png",
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.notif.title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black)),
                SizedBox(height: 4),
                Text(controller.notif.subtitle,
                    style: TextStyle(fontSize: 12, color: Color(0xFF9F9DA4))),
              ],
            ),
          ),
          Text(controller.notif.time,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Color(0xFF9F9DA4))),
        ],
      ),
    );
  }

  Widget _buildDateSection(DateTime date, bool isDark) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final startDay = date.day - (date.weekday - 1);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Date & Times",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black)),
            Text(
              "${controller.monthName(date.month)}, ${date.year}",
              style: TextStyle(fontSize: 14, color: Color(0xFF9F9DA4)),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (i) {
            final day = startDay + i;
            final isSelected = day == date.day;
            return Column(
              children: [
                Text(days[i],
                    style: TextStyle(
                        fontSize: 11,
                        color: isSelected ? Color(0xFF5B3EFF) : Color(0xFF9F9DA4),
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400)),
                SizedBox(height: 6),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFF5B3EFF) : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "$day",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : isDark
                                  ? Colors.white70
                                  : Color(0xFF3D3D3D)),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildClock(bool isDark) {
    return Column(
      children: [
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildModeChip("Hour", controller.isSelectingHour.value,
                    () => controller.isSelectingHour.value = true, isDark),
                SizedBox(width: 12),
                _buildModeChip("Minute", !controller.isSelectingHour.value,
                    () => controller.isSelectingHour.value = false, isDark),
              ],
            )),
        SizedBox(height: 16),
        Obx(() => RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Color(0xFF3D3D3D),
                    letterSpacing: 2),
                children: [
                  TextSpan(
                    text: controller.selectedHour.value.toString().padLeft(2, '0'),
                    style: TextStyle(
                      color: controller.isSelectingHour.value
                          ? Color(0xFF5B3EFF)
                          : isDark ? Colors.white : Color(0xFF3D3D3D),
                    ),
                  ),
                  TextSpan(text: ":"),
                  TextSpan(
                    text: controller.selectedMinute.value.toString().padLeft(2, '0'),
                    style: TextStyle(
                      color: !controller.isSelectingHour.value
                          ? Color(0xFF5B3EFF)
                          : isDark ? Colors.white : Color(0xFF3D3D3D),
                    ),
                  ),
                ],
              ),
            )),
        SizedBox(height: 16),
        Obx(() => Center(
              child: SizedBox(
                width: 260,
                height: 260,
                child: GestureDetector(
                  onPanStart: (details) => controller.onClockDrag(
                      details.localPosition, Size(260, 260)),
                  onPanUpdate: (details) => controller.onClockDrag(
                      details.localPosition, Size(260, 260)),
                  child: CustomPaint(
                    painter: InteractiveClockPainter(
                      hour: controller.selectedHour.value,
                      minute: controller.selectedMinute.value,
                      isSelectingHour: controller.isSelectingHour.value,
                      isDark: isDark,
                    ),
                  ),
                ),
              ),
            )),
        SizedBox(height: 20),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildQuickTimeBtn("AM", controller.selectedHour.value < 12,
                    () => controller.setAM(), isDark),
                SizedBox(width: 12),
                _buildQuickTimeBtn("PM", controller.selectedHour.value >= 12,
                    () => controller.setPM(), isDark),
              ],
            )),
      ],
    );
  }

  Widget _buildModeChip(String label, bool selected, VoidCallback onTap, bool isDark) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? Color(0xFF5B3EFF)
              : isDark ? const Color(0xFF1C1A2E) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: selected
              ? [BoxShadow(
                  color: Color(0xFF5B3EFF).withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 3))]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : Color(0xFF9F9DA4)),
        ),
      ),
    );
  }

  Widget _buildQuickTimeBtn(String label, bool active, VoidCallback onTap, bool isDark) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 36,
        decoration: BoxDecoration(
          color: active
              ? Color(0xFF5B3EFF)
              : isDark ? const Color(0xFF1C1A2E) : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: active ? Colors.white : Color(0xFF9F9DA4)),
          ),
        ),
      ),
    );
  }

  Widget _buildLocation(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Location",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black)),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1C1A2E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF0F0E1A) : const Color(0xFFEEECF5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset("assets/map.png"),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  "https://maps.app.goo.gl/EeDt2g4AYt84hduj8",
                  style: TextStyle(fontSize: 12, color: Color(0xFF5B3EFF)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.chevron_right, color: Color(0xFF9F9DA4)),
            ],
          ),
        ),
      ],
    );
  }
}

class InteractiveClockPainter extends CustomPainter {
  final int hour;
  final int minute;
  final bool isSelectingHour;
  final bool isDark;

  InteractiveClockPainter({
    required this.hour,
    required this.minute,
    required this.isSelectingHour,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(
        center,
        radius,
        Paint()..color = isDark ? const Color(0xFF1C1A2E) : Color(0xFFE8E6F0));

    final tickPaint = Paint()
      ..color = isDark ? Colors.white24 : Color(0xFFCBC8D8)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 60; i++) {
      final angle = (i * 6 - 90) * math.pi / 180;
      final isMajor = i % 5 == 0;
      final outerR = radius - 8;
      final innerR = isMajor ? radius - 18 : radius - 13;
      canvas.drawLine(
        Offset(center.dx + outerR * math.cos(angle),
            center.dy + outerR * math.sin(angle)),
        Offset(center.dx + innerR * math.cos(angle),
            center.dy + innerR * math.sin(angle)),
        tickPaint,
      );
    }

    final textStyle = TextStyle(
        fontSize: 14,
        color: isDark ? Colors.white70 : Colors.grey[700],
        fontWeight: FontWeight.w600);

    for (int i = 1; i <= 12; i++) {
      final angle = (i * 30 - 90) * math.pi / 180;
      final pos = Offset(
        center.dx + (radius - 32) * math.cos(angle),
        center.dy + (radius - 32) * math.sin(angle),
      );
      final tp = TextPainter(
        text: TextSpan(text: '$i', style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(pos.dx - tp.width / 2, pos.dy - tp.height / 2));
    }

    final activeAngle = isSelectingHour
        ? ((hour % 12 + minute / 60) * 30 - 90) * math.pi / 180
        : (minute * 6 - 90) * math.pi / 180;

    final activeHandLength = isSelectingHour ? radius - 65 : radius - 48;
    canvas.drawLine(
      center,
      Offset(
        center.dx + activeHandLength * math.cos(activeAngle),
        center.dy + activeHandLength * math.sin(activeAngle),
      ),
      Paint()
        ..color = Color(0xFF5B3EFF).withOpacity(0.25)
        ..strokeWidth = 28
        ..strokeCap = StrokeCap.round,
    );

    final minAngle = (minute * 6 - 90) * math.pi / 180;
    final minHandEnd = Offset(
      center.dx + (radius - 48) * math.cos(minAngle),
      center.dy + (radius - 48) * math.sin(minAngle),
    );
    canvas.drawLine(
      center,
      minHandEnd,
      Paint()
        ..color = isSelectingHour
            ? Color(0xFF5B3EFF).withOpacity(0.4)
            : Color(0xFF5B3EFF)
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round,
    );

    final hourAngle = ((hour % 12 + minute / 60) * 30 - 90) * math.pi / 180;
    final hourHandEnd = Offset(
      center.dx + (radius - 65) * math.cos(hourAngle),
      center.dy + (radius - 65) * math.sin(hourAngle),
    );
    canvas.drawLine(
      center,
      hourHandEnd,
      Paint()
        ..color = isSelectingHour
            ? Color(0xFF5B3EFF)
            : Color(0xFF5B3EFF).withOpacity(0.4)
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round,
    );

    final activeEnd = isSelectingHour ? hourHandEnd : minHandEnd;

    canvas.drawCircle(
        activeEnd,
        18,
        Paint()
          ..color = Color(0xFF5B3EFF).withOpacity(0.15)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8));

    canvas.drawCircle(activeEnd, 12, Paint()..color = Color(0xFF5B3EFF));

    final dotLabel = isSelectingHour
        ? '${hour % 12 == 0 ? 12 : hour % 12}'
        : '${minute.toString().padLeft(2, '0')}';
    final dotText = TextPainter(
      text: TextSpan(
          text: dotLabel,
          style: TextStyle(
              fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    dotText.paint(
        canvas,
        Offset(activeEnd.dx - dotText.width / 2,
            activeEnd.dy - dotText.height / 2));

    canvas.drawCircle(center, 5, Paint()..color = Color(0xFF5B3EFF));
    canvas.drawCircle(center, 3, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant InteractiveClockPainter old) =>
      old.hour != hour ||
      old.minute != minute ||
      old.isSelectingHour != isSelectingHour ||
      old.isDark != isDark;
}