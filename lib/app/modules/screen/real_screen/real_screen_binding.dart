import 'package:flutter_application_1/app/modules/screen/real_screen/real_screen_view.dart';
import 'package:get/get.dart';

class ReelsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RealScreenViewController>(() => RealScreenViewController());
  }
}