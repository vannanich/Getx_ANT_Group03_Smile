import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SleepModeController extends GetxController {
  // Timer variables
  var isTimerRunning = false.obs;
  var hours = 0.obs;
  var minutes = 0.obs;
  var seconds = 0.obs;
  var totalSeconds = 0.obs;
  
  // Selected sound
  var selectedSoundIndex = 0.obs;
  
  // List of sounds
  final List<String> sounds = [
    'Typhoon',
    'Sleet',
    'Heavenly D.',
    'Snoozy Winter',
    'Cloudiness',
    'Desert Wind',
    'Starry Nights',
    'Tribal Druma',
    'Medium Rain',
    'Snowy Bre.',
    'Heavy Rain',
    'Wind'
  ];
  
  // Timer instance
  late Timer _timer;
  
  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
  
  void updateHours(int value) {
    hours.value = value;
    updateTotalSeconds();
  }
  
  void updateMinutes(int value) {
    minutes.value = value;
    updateTotalSeconds();
  }
  
  void updateSeconds(int value) {
    seconds.value = value;
    updateTotalSeconds();
  }
  
  void updateTotalSeconds() {
    totalSeconds.value = (hours.value * 3600) + (minutes.value * 60) + seconds.value;
  }
  
  void startTimer() {
    if (totalSeconds.value > 0 && !isTimerRunning.value) {
      isTimerRunning.value = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (totalSeconds.value > 0) {
          totalSeconds.value--;
          _updateTimeFromSeconds();
        } else {
          stopTimer();
          _onTimerComplete();
        }
      });
    }
  }
  
  void pauseTimer() {
    if (isTimerRunning.value) {
      isTimerRunning.value = false;
      _timer.cancel();
    }
  }
  
  void resetTimer() {
    pauseTimer();
    hours.value = 0;
    minutes.value = 0;
    seconds.value = 0;
    totalSeconds.value = 0;
  }
  
  void stopTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    isTimerRunning.value = false;
  }
  
  void _updateTimeFromSeconds() {
    hours.value = totalSeconds.value ~/ 3600;
    minutes.value = (totalSeconds.value % 3600) ~/ 60;
    seconds.value = totalSeconds.value % 60;
  }
  
  void _onTimerComplete() {
    // Show notification or play alarm
    Get.snackbar(
      'Time\'s Up!',
      'Your sleep timer has completed',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF2D1B6B),
      colorText: Colors.white,
    );
  }
  
  void selectSound(int index) {
    selectedSoundIndex.value = index;
  }
  
  String getFormattedTime() {
    return '${hours.value.toString().padLeft(2, '0')} : ${minutes.value.toString().padLeft(2, '0')} : ${seconds.value.toString().padLeft(2, '0')}';
  }
}