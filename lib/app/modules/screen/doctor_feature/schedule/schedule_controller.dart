import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleController extends GetxController {
  final selectedDate = DateTime.now().obs;
  final selectedHour = 7.obs;
  final selectedMinute = 0.obs;
  final isAM = true.obs;

  // Generate week days starting from today
  List<DateTime> get weekDays {
    final now = DateTime.now();
    return List.generate(6, (i) => now.add(Duration(days: i)));
  }

  String get monthYear {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[selectedDate.value.month - 1]}, ${selectedDate.value.year}';
  }

  String get dayName {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[selectedDate.value.weekday - 1];
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    update();
  }

  void setHour(int hour) {
    selectedHour.value = hour;
    update();
  }

  void setMinute(int minute) {
    selectedMinute.value = minute;
    update();
  }

  void toggleAMPM(bool am) {
    isAM.value = am;
    update();
  }

  void onCancel() => Get.back();

  void onConfirm() {
    final h = selectedHour.value;
    final m = selectedMinute.value.toString().padLeft(2, '0');
    final period = isAM.value ? 'AM' : 'PM';
    Get.snackbar(
      'Appointment Booked',
      'Time: $h:$m $period on ${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}',
      backgroundColor: const Color(0xFF5B2DC4),
      colorText: Colors.white,
      borderRadius: 14,
      margin: const EdgeInsets.all(16),
    );
  }
}