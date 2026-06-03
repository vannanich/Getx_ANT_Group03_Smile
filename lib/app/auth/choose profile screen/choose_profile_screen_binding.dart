part of 'choose_profile_screen_view.dart';

class ChooseProfileScreenViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseProfileScreenViewController>(
      () => ChooseProfileScreenViewController(),
    );
  }
}