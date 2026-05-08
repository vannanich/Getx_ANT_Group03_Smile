part of 'quote_screen_view.dart';

class QuoteModel {
  final String text;
  final String author;
  final String imageUrl;
  final int likes;
  final int downloads;
  final int shares;

  const QuoteModel({
    required this.text,
    required this.author,
    required this.imageUrl,
    required this.likes,
    required this.downloads,
    required this.shares,
  });
}

class QuoteScreenController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxBool isLiked = false.obs;

  final List<QuoteModel> quotes = [
    QuoteModel(
      text: '"In the middle of difficulty lies opportunity."',
      author: '— Albert Einstein',
      imageUrl:
          'https://images.unsplash.com/photo-1448375240586-882707db888b?w=800',
      likes: 999,
      downloads: 321,
      shares: 151,
    ),
    QuoteModel(
      text: '"The only way to do great work is to love what you do."',
      author: '— Steve Jobs',
      imageUrl:
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
      likes: 854,
      downloads: 210,
      shares: 98,
    ),
    QuoteModel(
      text:
          '"It does not matter how slowly you go as long as you do not stop."',
      author: '— Confucius',
      imageUrl:
          'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800',
      likes: 762,
      downloads: 189,
      shares: 74,
    ),
  ];

  QuoteModel get currentQuote => quotes[currentIndex.value];
  bool get canGoPrevious => currentIndex.value > 0;
  bool get canGoNext => currentIndex.value < quotes.length - 1;

  void nextQuote() {
    if (canGoNext) {
      currentIndex.value++;
      isLiked.value = false;
    }
  }

  void previousQuote() {
    if (canGoPrevious) {
      currentIndex.value--;
      isLiked.value = false;
    }
  }

  void toggleLike() => isLiked.toggle();

  void onDownload() {
    Get.snackbar(
      'Downloaded',
      'Quote saved to your gallery',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black54,
      colorText: Colors.white,
      margin: EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void onShare() {
    Get.snackbar(
      'Share',
      'Sharing quote...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black54,
      colorText: Colors.white,
      margin: EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
