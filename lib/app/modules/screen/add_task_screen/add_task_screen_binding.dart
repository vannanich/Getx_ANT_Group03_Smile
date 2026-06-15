part of 'add_task_screen_view.dart';

class AddTaskScreenViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => AddTaskScreenViewController());
   }
}