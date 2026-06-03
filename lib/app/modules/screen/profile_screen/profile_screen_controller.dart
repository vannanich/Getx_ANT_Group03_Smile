// ignore_for_file: must_call_super

part of 'profile_screen_view.dart';

class ProfileScreenViewController extends GetxController {
  // Reactive state — connect your backend here
  final savedQuotesCount = 0.obs;
  final dailyStreakDays = 2.obs;
  final currentMood = 'Calm'.obs;
  final reflectionsCount = 0.obs;
  final username = 'Username'.obs;

  @override
  void onInit() {}
}
