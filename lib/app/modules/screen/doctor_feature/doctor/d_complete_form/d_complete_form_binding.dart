
import 'package:flutter_application_1/app/modules/screen/doctor_feature/doctor/d_complete_form/d_complete_form_controller.dart';
import 'package:get/get.dart';

class DCompleteFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DCompleteFormController>(() => DCompleteFormController());
  }
}