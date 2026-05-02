part of 'read_book_screen_view.dart';

class ReadBookScreenBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => ReadBookScreenController());
   }
}