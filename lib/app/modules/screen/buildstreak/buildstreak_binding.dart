import 'package:flutter_application_1/app/modules/screen/buildstreak/buildstreak_controller.dart';
import 'package:get/get.dart';




class BuildstreakViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => BuildstreakViewController());
   }
}