part of 'mood_screen_view.dart';

class MoodScreenBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => MoodScreenController());
   }
}