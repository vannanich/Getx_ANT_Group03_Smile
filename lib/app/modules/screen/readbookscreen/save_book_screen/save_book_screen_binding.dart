part of 'save_book_screen_view.dart';

class SaveBookScreenBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => SaveBookScreenController());
   }
}