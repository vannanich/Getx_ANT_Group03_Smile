part of 'search_screen_view.dart';

class SearchScreenViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchScreenViewController>(
      () => SearchScreenViewController(),
    );
  }
}