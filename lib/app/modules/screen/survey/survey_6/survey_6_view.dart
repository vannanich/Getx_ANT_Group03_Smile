import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'survey_6_binding.dart';
part 'survey_6_controller.dart';

class Survey6View extends GetView<Survey6ViewController> {
  const Survey6View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Center(child: Text("Ho"))]),
    );
  }
}
