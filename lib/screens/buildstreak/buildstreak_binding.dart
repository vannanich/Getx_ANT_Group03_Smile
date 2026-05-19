import 'package:get/get.dart';

import 'package:smile_version2/screens/buildstreak/buildstreak_controller.dart';



class BuildstreakViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => BuildstreakViewController());
   }
}