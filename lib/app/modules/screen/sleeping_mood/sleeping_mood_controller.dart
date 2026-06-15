

import 'dart:async';

import 'package:get/get.dart';

class SleepingmoodScreenViewController extends GetxController {
  final RxInt hours = 0.obs;
  final RxInt minutes = 0.obs;
  final RxInt seconds = 0.obs;
  final RxBool isRunning = false.obs;
  Timer? _timer;

 
  void toggleTimer() {
    if (isRunning.value) {
     
      _timer?.cancel();
      isRunning.value = false;
    } else {
    
      isRunning.value = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        seconds.value++;
        if (seconds.value == 60) {
          seconds.value = 0;
          minutes.value++;
        }
        if (minutes.value == 60) {
          minutes.value = 0;
          hours.value++;
        }
      });
    }
  }

  void resetTimer() {
    _timer?.cancel();
    isRunning.value = false;
    hours.value = 0;
    minutes.value = 0;
    seconds.value = 0;
  }

  String pad(int n) => n.toString().padLeft(2, '0');

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }
}