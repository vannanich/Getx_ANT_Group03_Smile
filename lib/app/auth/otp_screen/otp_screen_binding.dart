part of 'otp_screen_view.dart';

class OtpScreenViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => OtpScreenViewController());
   }
}