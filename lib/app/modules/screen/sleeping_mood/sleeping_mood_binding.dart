import 'package:flutter_application_1/app/modules/screen/sleeping_mood/sleeping_mood_controller.dart';
import 'package:get/get.dart';

class SleepModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SleepModeController>(() => SleepModeController());
  }
}