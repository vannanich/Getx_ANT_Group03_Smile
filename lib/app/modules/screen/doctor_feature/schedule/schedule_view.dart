import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/schedule/schedule_controller.dart';
import 'package:get/get.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDateHeader(),
                      const SizedBox(height: 16),
                      _buildWeekDays(),
                      const SizedBox(height: 20),
                      const Text(
                        'SELECT TIME',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF9B8AB8),
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildTimePicker(),
                      const SizedBox(height: 16),
                      Expanded(child: _buildClock()),
                      _buildActions(),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildBookButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDateHeader() {
    return GetBuilder<ScheduleController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Date',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2D1B6B),
            ),
          ),
          Row(
            children: [
              Text(
                controller.monthYear,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D1B6B),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Color(0xFF2D1B6B),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeekDays() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return GetBuilder<ScheduleController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(controller.weekDays.length, (i) {
          final date = controller.weekDays[i];
          final isSelected =
              date.day == controller.selectedDate.value.day &&
              date.month == controller.selectedDate.value.month;
          return GestureDetector(
            onTap: () => controller.selectDate(date),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 42,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF6B3FD4)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    days[i],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF9B8AB8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF2D1B6B),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTimePicker() {
    return GetBuilder<ScheduleController>(
      builder: (controller) => Row(
        children: [
          // Hour
          Text(
            controller.selectedHour.value.toString(),
            style: const TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w300,
              color: Color(0xFF6B3FD4),
            ),
          ),
          const Text(
            ' : ',
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w300,
              color: Color(0xFF2D1B6B),
            ),
          ),
          // Minute
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F0FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              controller.selectedMinute.value.toString().padLeft(2, '0'),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D1B6B),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // AM/PM
          Column(
            children: [
              GestureDetector(
                onTap: () => controller.toggleAMPM(true),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: controller.isAM.value
                        ? const Color(0xFF6B3FD4)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'AM',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: controller.isAM.value
                          ? Colors.white
                          : const Color(0xFF9B8AB8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () => controller.toggleAMPM(false),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: !controller.isAM.value
                        ? const Color(0xFF6B3FD4)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'PM',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: !controller.isAM.value
                          ? Colors.white
                          : const Color(0xFF9B8AB8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClock() {
  return GetBuilder<ScheduleController>(
    builder: (controller) => LayoutBuilder(
      builder: (context, constraints) => GestureDetector(
        onPanUpdate: (details) {
          final center = Offset(
            constraints.maxWidth / 2,
            constraints.maxHeight / 2,
          );
          final position = details.localPosition - center;
          final angle = atan2(position.dy, position.dx);
          final hour = ((angle / (2 * pi) * 12) + 3).round() % 12;
          controller.setHour(hour == 0 ? 12 : hour);
        },
        child: CustomPaint(
          painter: _ClockPainter(
            hour: controller.selectedHour.value,
            minute: controller.selectedMinute.value,
          ),
          child: Container(),
        ),
      ),
    ),
  );
}

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: controller.onCancel,
          child: const Text(
            'CANCEL',
            style: TextStyle(
              color: Color(0xFF6B3FD4),
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: controller.onConfirm,
          child: const Text(
            'OK',
            style: TextStyle(
              color: Color(0xFF6B3FD4),
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: controller.onConfirm,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 52),
          backgroundColor: const Color(0xFF5B2DC4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 4,
        ),
        child: const Text(
          'Book an appointment',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

// Clock painter
class _ClockPainter extends CustomPainter {
  final int hour;
  final int minute;

  _ClockPainter({required this.hour, required this.minute});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 10;

    // Clock face
    final facePaint = Paint()..color = const Color(0xFFF4F0FF);
    canvas.drawCircle(center, radius, facePaint);

    // Hour numbers
    final textStyle = const TextStyle(
      fontSize: 14,
      color: Color(0xFF2D1B6B),
      fontWeight: FontWeight.w500,
    );

    for (int i = 1; i <= 12; i++) {
      final angle = (i * 30 - 90) * pi / 180;
      final x = center.dx + (radius - 24) * cos(angle);
      final y = center.dy + (radius - 24) * sin(angle);
      final tp = TextPainter(
        text: TextSpan(text: '$i', style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));
    }

    // Selected hour dot
    final selectedAngle = (hour * 30 - 90) * pi / 180;
    final dotX = center.dx + (radius - 24) * cos(selectedAngle);
    final dotY = center.dy + (radius - 24) * sin(selectedAngle);
    final dotPaint = Paint()..color = const Color(0xFF6B3FD4);
    canvas.drawCircle(Offset(dotX, dotY), 16, dotPaint);

    // Hour hand
    final hourAngle = (hour * 30 - 90) * pi / 180;
    final hourPaint = Paint()
      ..color = const Color(0xFF6B3FD4)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      center,
      Offset(
        center.dx + (radius * 0.5) * cos(hourAngle),
        center.dy + (radius * 0.5) * sin(hourAngle),
      ),
      hourPaint,
    );

    // Minute hand
    final minuteAngle = (minute * 6 - 90) * pi / 180;
    final minutePaint = Paint()
      ..color = const Color(0xFF9B8AB8)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      center,
      Offset(
        center.dx + (radius * 0.65) * cos(minuteAngle),
        center.dy + (radius * 0.65) * sin(minuteAngle),
      ),
      minutePaint,
    );

    // Center dot
    canvas.drawCircle(center, 5, dotPaint);
  }

  @override
  bool shouldRepaint(_ClockPainter old) =>
      old.hour != hour || old.minute != minute;
}