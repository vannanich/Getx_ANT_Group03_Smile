import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'save_book_screen_binding.dart';
part 'save_book_screen_controller.dart';

class SaveBookScreenView extends GetView<SaveBookScreenController> {
  const SaveBookScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Save Book Screen")));
  }
}
