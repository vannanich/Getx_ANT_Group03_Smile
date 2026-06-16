part of 'home_screen_view.dart';

class HomeScreenViewController extends GetxController {
  final box = GetStorage();
  var username = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      if (token == null) {
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/me'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // ✅ Now shows the real logged-in username
        username.value = data['username'] ?? 'User';
      } else {
        // Token expired or invalid — force re-login
        box.remove('token');
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      Get.snackbar('Error', 'Cannot connect to server');
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    try {
      final token = box.read('token');
      if (token != null) {
        // ✅ Tell the server to clear the token too
        await http.post(
          Uri.parse('http://10.0.2.2:8000/logout'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
      }
    } catch (_) {
      // Even if server call fails, still log out locally
    } finally {
      box.remove('token');
      Get.offAllNamed(AppRoutes.login);
    }
  }
}