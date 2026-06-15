part of 'real_screen_view.dart';

class RealScreenViewController extends GetxController {

  final selectedIndex = 0.obs;
  final pageController = PageController();

  void changeTab(int index) {
    selectedIndex.value = index;

    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onInit() {
    super.onInit();
  }
}