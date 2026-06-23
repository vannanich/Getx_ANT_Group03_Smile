part of 'patient_list_screen_view.dart';

class PatientListScreenViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => PatientListScreenViewController());
   }
}