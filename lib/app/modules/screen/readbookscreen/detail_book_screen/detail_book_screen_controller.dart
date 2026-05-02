part of 'detail_book_screen_view.dart';

class DetailBookScreenController extends GetxController {
  final isFavorited = false.obs;
  final isDownloaded = false.obs;
  final selectedRating = 0.obs;

  void onFavoriteTap() => isFavorited.toggle();
  void onDownloadTap() => isDownloaded.toggle();
  void onRatingTap(int star) => selectedRating.value = star;

  void onReadTap() {
    Get.snackbar(
      'Read me',
      'Opening book reader...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF5B33B5),
      colorText: Colors.white,
    );
  }
}
