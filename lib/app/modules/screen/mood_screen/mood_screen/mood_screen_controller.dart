part of 'mood_screen_view.dart';

class MoodItem {
  final String emoji;
  final String label;
  final Color selectedColor;
  final Color selectedBorder;

  const MoodItem({
    required this.emoji,
    required this.label,
    required this.selectedColor,
    required this.selectedBorder,
  });
}

class WeekDay {
  final String emoji;
  final String label;
  final double heightFraction;
  final Color barColor;

  const WeekDay({
    required this.emoji,
    required this.label,
    required this.heightFraction,
    required this.barColor,
  });
}

class MoodScreenController extends GetxController {
  final RxInt selectedIndex = (-1).obs;
  final RxBool isSaving = false.obs;

  final List<MoodItem> moods = [
    MoodItem(
      emoji: '😊',
      label: 'Happy',
      selectedColor: Color(0xFFFFF3DC),
      selectedBorder: Color(0xFFFFB800),
    ),
    MoodItem(
      emoji: '😌',
      label: 'Calm',
      selectedColor: Color(0xFFDCF5F0),
      selectedBorder: Color(0xFF34C8A6),
    ),
    MoodItem(
      emoji: '😢',
      label: 'Sad',
      selectedColor: Color(0xFFDCEEFF),
      selectedBorder: Color(0xFF3A9EE8),
    ),
    MoodItem(
      emoji: '😠',
      label: 'Angry',
      selectedColor: Color(0xFFFFDCDC),
      selectedBorder: Color(0xFFE84C3A),
    ),
    MoodItem(
      emoji: '😰',
      label: 'Anxious',
      selectedColor: Color(0xFFFFEBDC),
      selectedBorder: Color(0xFFFF8C42),
    ),
    MoodItem(
      emoji: '😴',
      label: 'Tired',
      selectedColor: Color(0xFFEADCFF),
      selectedBorder: Color(0xFF9B6FE8),
    ),
    MoodItem(
      emoji: '🥰',
      label: 'Loved',
      selectedColor: Color(0xFFFFDCEE),
      selectedBorder: Color(0xFFE83A8C),
    ),
    MoodItem(
      emoji: '🤩',
      label: 'Excited',
      selectedColor: Color(0xFFFFF3DC),
      selectedBorder: Color(0xFFFFB800),
    ),
    MoodItem(
      emoji: '😐',
      label: 'Neutral',
      selectedColor: Color(0xFFEEEEEE),
      selectedBorder: Color(0xFF9F9DA4),
    ),
  ];

  final List<WeekDay> weekData = [
    WeekDay(
      emoji: '😊',
      label: 'Mon',
      heightFraction: 0.85,
      barColor: Color(0xFFF9EEC0),
    ),
    WeekDay(
      emoji: '😌',
      label: 'Tue',
      heightFraction: 0.55,
      barColor: Color(0xFFC8F0E1),
    ),
    WeekDay(
      emoji: '😰',
      label: 'Wed',
      heightFraction: 0.40,
      barColor: Color(0xFFFADFCA),
    ),
    WeekDay(
      emoji: '😊',
      label: 'Thu',
      heightFraction: 0.90,
      barColor: Color(0xFFF9EEC0),
    ),
    WeekDay(
      emoji: '🥱',
      label: 'Fri',
      heightFraction: 0.35,
      barColor: Color(0xFFF8D7E8),
    ),
    WeekDay(
      emoji: '🤩',
      label: 'Sat',
      heightFraction: 1.00,
      barColor: Color(0xFFF9EEC0),
    ),
    WeekDay(
      emoji: '🥰',
      label: 'Sun',
      heightFraction: 0.90,
      barColor: Color(0xFFF8D7E8),
    ),
  ];

  bool get hasSelection => selectedIndex.value != -1;
  MoodItem? get selectedMood =>
      hasSelection ? moods[selectedIndex.value] : null;
  void selectMood(int index) {
    selectedIndex.value = selectedIndex.value == index ? -1 : index;
  }

  bool isSelected(int index) => selectedIndex.value == index;

  Future<void> saveMood() async {
    if (!hasSelection || isSaving.value) return;
    isSaving.value = true;
    await Future.delayed(Duration(milliseconds: 800));

    isSaving.value = false;
    final mood = selectedMood!;

    Get.snackbar(
      'Mood Logged! ${mood.emoji}',
      'You\'re feeling ${mood.label} today.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: mood.selectedBorder,
      colorText: Colors.white,
      margin: EdgeInsets.all(16),
      borderRadius: 16,
      duration: Duration(seconds: 2),
      icon: Icon(Icons.check_circle_rounded, color: Colors.white),
    );
  }

  void clearSelection() => selectedIndex.value = -1;
}
