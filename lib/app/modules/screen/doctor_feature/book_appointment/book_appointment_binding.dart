import 'package:flutter_application_1/app/modules/screen/doctor_feature/book_appointment/book_appointment_controller.dart';
import 'package:get/get.dart';

class DoctorAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorAppointmentController>(() => DoctorAppointmentController());
  }
}