import 'package:flutter_application_1/app/modules/screen/doctor_feature/doctor/d_homescreen/d_today_appoitment/d_today_appoitment_controller.dart';
import 'package:get/get.dart';

class DTodayAppoitmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DTodayAppoitmentController>(() => DTodayAppoitmentController());
  }
}