part of 'edit_profile_screen_view.dart';

class EditProfileScreenViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => EditProfileScreenViewController());
   }
}