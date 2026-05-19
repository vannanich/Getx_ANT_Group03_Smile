part of 'buttonnext_screen_view.dart';

class ButtonnextScreenViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => ButtonnextScreenViewController());
   }
}