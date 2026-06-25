part of 'information_vdo_img_screen_view.dart';

class InformationVdoImgScreenViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => InformationVdoImgScreenViewController());
   }
}