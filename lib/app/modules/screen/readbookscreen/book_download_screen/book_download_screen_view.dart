import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'book_download_screen_binding.dart';
part 'book_download_screen_controller.dart';

class BookDownloadScreenView extends GetView<BookDownloadScreenController> {
  const BookDownloadScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Book Download")));
  }
}
