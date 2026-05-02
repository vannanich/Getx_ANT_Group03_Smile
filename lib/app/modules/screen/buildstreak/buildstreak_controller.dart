import 'package:get/get.dart';

class BuildstreakViewController extends GetxController {
   
  //   var streak = 2.obs;
   
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  var streakCount = 2.obs;

  void incrementStreak() {
    streakCount.value++;
  }
}