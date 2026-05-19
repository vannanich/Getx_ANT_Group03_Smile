import 'package:get/get.dart';
import 'package:smile_version2/screens/buttonnext_screen/buttonnext_screen_view.dart';
import 'package:smile_version2/routes/app_routes.dart';
import 'package:smile_version2/screens/selected_role_screen/select_role_screen_view.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.selectRole,
      page: () => SelectRoleScreenView(),
      binding: SelectRoleScreenBinding(),
    ),

    GetPage(
      name: Routes.nextScreen,
      page: () => ButtonnextScreenView(),
      binding: ButtonnextScreenViewBinding(),
    ),
  ];
}
