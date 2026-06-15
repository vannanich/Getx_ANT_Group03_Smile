part of 'goal_screen_view.dart';

class GoalScreenViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GoalScreenController());
  }
}
