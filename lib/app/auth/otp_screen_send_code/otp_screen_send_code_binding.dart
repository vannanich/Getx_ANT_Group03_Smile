part of 'otp_screen_send_code_view.dart';

class OtpScreenSendCodeViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpScreenSendCodeViewController());
  }
}
