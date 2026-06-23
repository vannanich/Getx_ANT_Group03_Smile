part of 'docter_check_message_view.dart';

class DocterCheckMessageViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => DocterCheckMessageViewController());
   }
}