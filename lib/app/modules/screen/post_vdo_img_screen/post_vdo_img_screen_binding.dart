part of 'post_vdo_img_screen_view.dart';

class PostVdoImgScreenViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => PostVdoImgScreenViewController());
   }
}