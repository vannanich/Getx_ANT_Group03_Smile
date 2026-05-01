import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/mood_selection/widget/result_sheet.dart';
import 'package:get/get.dart';

import 'model/mood_model.dart';

class MoodSelectorController extends GetxController
    with GetTickerProviderStateMixin {
  static const int tileCount = 9;

  final questionIndex = 0.obs;
  final selectedIndex = RxnInt();
  final isTransitioning = false.obs;
  final phase = 'idle'.obs;
  final answers = <int>[].obs;

  late final List<AnimationController> tileControllers;
  late final AnimationController progressController;
  late Animation<double> progressAnimation;

  MoodQuestion get currentQuestion => questions[questionIndex.value];
  bool get canContinue => !isTransitioning.value && selectedIndex.value != null;

  @override
  void onInit() {
    super.onInit();

    tileControllers = List.generate(
      tileCount,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 260),
      ),
    );

    progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    progressAnimation = Tween<double>(begin: 0, end: 1 / questions.length)
        .animate(
          CurvedAnimation(parent: progressController, curve: Curves.easeOut),
        );

    progressController.forward();
  }

  @override
  void onClose() {
    for (final controller in tileControllers) {
      controller.dispose();
    }
    progressController.dispose();
    super.onClose();
  }

  void selectMood(int index) {
    if (isTransitioning.value) return;
    selectedIndex.value = index;
  }

  List<int> order(int origin) {
    final fr = origin ~/ 3;
    final fc = origin % 3;

    final list = List.generate(tileCount, (i) {
      final r = i ~/ 3;
      final c = i % 3;
      return MapEntry(i, (r - fr) * (r - fr) + (c - fc) * (c - fc));
    });

    list.sort((a, b) => a.value.compareTo(b.value));
    return list.map((e) => e.key).toList();
  }

  Future<void> runTransition(int nextQuestion) async {
    final origin = selectedIndex.value ?? 4;
    final ordered = order(origin);
    const int gap = 30;

    phase.value = 'exiting';
    update();

    for (int i = 0; i < ordered.length; i++) {
      final idx = ordered[i];
      Future.delayed(Duration(milliseconds: i * gap), () {
        if (isClosed) return;
        tileControllers[idx].animateTo(
          1.0,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeIn,
        );
      });
    }

    await Future.delayed(Duration(milliseconds: (tileCount - 1) * gap + 220));

    for (final controller in tileControllers) {
      controller.value = 1.0;
    }

    questionIndex.value = nextQuestion;
    selectedIndex.value = null;
    phase.value = 'entering';
    update();

    final double from = nextQuestion / questions.length;
    final double to = (nextQuestion + 1) / questions.length;

    progressAnimation = Tween<double>(begin: from, end: to).animate(
      CurvedAnimation(parent: progressController, curve: Curves.easeOut),
    );

    progressController.forward(from: 0);

    await Future.delayed(const Duration(milliseconds: 30));

    for (int i = 0; i < ordered.length; i++) {
      final idx = ordered[i];
      Future.delayed(Duration(milliseconds: i * gap), () {
        if (isClosed) return;
        tileControllers[idx].animateTo(
          0.0,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutBack,
        );
      });
    }

    await Future.delayed(Duration(milliseconds: (tileCount - 1) * gap + 280));

    phase.value = 'idle';
    update();
  }

  Future<void> onContinue() async {
    if (isTransitioning.value || selectedIndex.value == null) return;

    if (questionIndex.value == questions.length - 1) {
      answers.add(selectedIndex.value!);
      showResults();
      return;
    }

    isTransitioning.value = true;
    answers.add(selectedIndex.value!);

    await runTransition(questionIndex.value + 1);

    isTransitioning.value = false;
    update();
  }

  Future<void> onBack() async {
    if (isTransitioning.value || questionIndex.value == 0) return;

    isTransitioning.value = true;
    selectedIndex.value = null;
    if (answers.isNotEmpty) {
      answers.removeLast();
    }
    update();

    await runTransition(questionIndex.value - 1);

    isTransitioning.value = false;
    update();
  }

  void onSkip() {
    if (isTransitioning.value) return;

    if (questionIndex.value == questions.length - 1) {
      showResults();
      return;
    }

    runSkipTransition();
  }

  Future<void> runSkipTransition() async {
    isTransitioning.value = true;
    selectedIndex.value = null;
    update();

    await runTransition(questionIndex.value + 1);

    isTransitioning.value = false;
    update();
  }

  void showResults() {
    Get.bottomSheet(
      ResultsSheet(controller: this),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }
}
