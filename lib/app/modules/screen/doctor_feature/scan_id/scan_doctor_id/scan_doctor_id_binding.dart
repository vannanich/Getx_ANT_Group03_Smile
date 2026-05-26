// lib/bindings/scan_doctor_id_binding.dart

import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/scan_id/scan_doctor_id/scan_doctor_id_controller.dart';

class ScanDoctorIdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScanDoctorIdController());
  }
}