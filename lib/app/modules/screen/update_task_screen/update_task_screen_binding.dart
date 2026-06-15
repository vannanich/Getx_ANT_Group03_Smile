part of 'update_task_screen_view.dart';

class UpdateTaskScreenViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => UpdateTaskScreenViewController());
   }
}