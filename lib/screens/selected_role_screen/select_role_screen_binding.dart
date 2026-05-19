part of 'select_role_screen_view.dart';

class SelectRoleScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectRoleScreenController());
  }
}
