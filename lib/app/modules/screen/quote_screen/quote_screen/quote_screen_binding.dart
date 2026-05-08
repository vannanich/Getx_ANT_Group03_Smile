part of 'quote_screen_view.dart';

class QuoteScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuoteScreenController());
  }
}
