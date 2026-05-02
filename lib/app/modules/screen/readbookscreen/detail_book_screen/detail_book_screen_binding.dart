part of 'detail_book_screen_view.dart';

class DetailBookScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailBookScreenController>(() => DetailBookScreenController());
  }
}
