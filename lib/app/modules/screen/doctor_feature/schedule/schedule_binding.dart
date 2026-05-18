part of 'schedule_view.dart';

class ScheduleViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => ScheduleViewController());
   }
}