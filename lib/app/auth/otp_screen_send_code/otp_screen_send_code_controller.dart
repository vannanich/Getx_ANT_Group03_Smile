part of 'otp_screen_send_code_view.dart';

class OtpScreenSendCodeViewController extends GetxController {
  late String email;

  RxInt seconds = 300.obs; // 5 minutes = 300 sec
  late Timer timer;

  @override
  void onInit() {
    super.onInit();

    email = Get.arguments ?? "";

    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds.value == 0) {
        t.cancel();
      } else {
        seconds.value--;
      }
    });
  }

  String get formattedTime {
    final m = (seconds.value ~/ 60).toString().padLeft(2, '0');
    final s = (seconds.value % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  
}