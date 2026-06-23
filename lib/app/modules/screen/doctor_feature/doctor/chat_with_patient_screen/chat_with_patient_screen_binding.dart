part of 'chat_with_patient_screen_view.dart';

class ChatWithPatientScreenViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => ChatWithPatientScreenViewController());
   }
}