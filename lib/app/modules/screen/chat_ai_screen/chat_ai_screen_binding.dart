import 'package:flutter_application_1/app/modules/screen/chat_ai_screen/chat_ai_screen_controller.dart';
import 'package:get/get.dart';

class AiChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AiChatController());
  }
}