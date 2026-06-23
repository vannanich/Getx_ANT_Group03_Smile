part of 'd_profilescreen_view.dart';

class DProfilescreenViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => DProfilescreenViewController());
   }
}