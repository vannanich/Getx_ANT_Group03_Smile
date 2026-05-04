part of 'read_book_screen_view.dart';

class ReadBookScreenController extends GetxController {
  RxList<int> savedBooks = <int>[].obs;
  RxList<int> downloadbooks = <int>[].obs;

  void toggleFavorite(int index) {
    if (savedBooks.contains(index)) {
      savedBooks.remove(index);
    } else {
      savedBooks.add(index);
    }
  }

  void toggleDownload(int index) {
    if (downloadbooks.contains(index)) {
      downloadbooks.remove(index);
    } else {
      downloadbooks.add(index);
    }
  }

  bool isFavorite(int index) => savedBooks.contains(index);
  bool isDownloaded(int index) => downloadbooks.contains(index);
}
