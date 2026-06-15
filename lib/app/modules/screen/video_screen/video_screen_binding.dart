part of 'video_screen_view.dart';

class VideoScreenViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => VideoScreenViewController(),fenix: true);
   }
}