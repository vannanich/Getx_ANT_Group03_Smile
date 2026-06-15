part of 'otp_screen_view.dart';

class OtpScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpScreenViewController>(
      () => OtpScreenViewController(),
    );
  }
}