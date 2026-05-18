import 'package:get/get.dart';
import 'chat_with_doctor_controller.dart';

class ChatWithDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatWithDoctorController());
  }
}