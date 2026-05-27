// lib/bindings/doctor_home_binding.dart

import 'package:flutter_application_1/app/modules/screen/doctor_feature/d_homescreen/d_homescreen_controller.dart';
import 'package:get/get.dart';

class DHomescreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorHomeController>(() => DoctorHomeController());
  }
}