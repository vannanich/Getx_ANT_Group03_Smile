part of 'sign_up_screen_view.dart';

class SignUpScreenViewController extends GetxController {
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();

  var isLoading = false.obs;
  var obscurePassword = true.obs;
  var obscureConfirm = true.obs;

  @override
  void onClose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.onClose();
  }

  void onNext() {
    final username = usernameCtrl.text.trim();
    final password = passwordCtrl.text;
    final confirm = confirmPasswordCtrl.text;

    if (username.isEmpty || password.isEmpty || confirm.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    if (password != confirm) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    // TODO: Call register API
    debugPrint('Username: $username');
  }

  void onGoogleSignUp() {
    // TODO: Google sign up
  }

  void onFacebookSignUp() {
    // TODO: Facebook sign up
  }
}