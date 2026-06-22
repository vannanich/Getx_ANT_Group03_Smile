import 'package:flutter_application_1/app/modules/screen/doctor_feature/User/book_appointment/schedule/schedule_controller.dart';
import 'package:get/get.dart';

class ScheduleBinding extends Bindings {
  @override
  void dependencies() {
Get.lazyPut<ScheduleBinding>(() => ScheduleBinding());  }
}