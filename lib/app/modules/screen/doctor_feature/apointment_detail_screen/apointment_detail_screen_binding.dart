part of 'apointment_detail_screen_view.dart';

class ApointmentDetailScreenViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => ApointmentDetailScreenViewController());
   }
}