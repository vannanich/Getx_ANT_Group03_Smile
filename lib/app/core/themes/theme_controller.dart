
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTheme(); // ← call it here
  }

  // ← put it here inside the class
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDark = prefs.getBool('isDarkMode') ?? false;
    isDarkMode.value = savedDark;
  }

  Future<void> toggleTheme() async {
    isDarkMode.toggle();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode.value);
  }
}
