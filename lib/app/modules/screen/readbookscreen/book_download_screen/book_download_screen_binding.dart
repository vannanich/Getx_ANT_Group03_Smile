part of 'book_download_screen_view.dart';

class BookDownloadScreenViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => BookDownloadScreenController());
   }
}