part of 'sign_up_screen_view.dart';

class SignUpScreenViewController extends GetxController {
  final usernameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();

  var isLoading = false.obs;
  var obscurePassword = true.obs;
  var obscureConfirm = true.obs;

  @override
  void onClose() {
    usernameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.onClose();
  }

  void onNext() async {
    final username = usernameCtrl.text.trim();
    final email = emailCtrl.text.trim();
    final password = passwordCtrl.text;
    final confirm = confirmPasswordCtrl.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    if (password != confirm) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar('Success', data['message'] ?? 'Account created!');
        Get.toNamed(AppRoutes.login);
      } else {
        Get.snackbar('Error', data['error'] ?? 'Something went wrong');
      }
    } catch (e) {
      Get.snackbar('Error', 'Cannot connect to server');
    } finally {
      isLoading.value = false;
    }
  }

  void onGoogleSignUp() {}
  void onFacebookSignUp() {}
}