import 'package:flutter_application_1/app/modules/screen/mood_selection/mood_selection_controller.dart';
import 'package:get/get.dart';

class MoodSelectionViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MoodSelectorController());
  }
}
