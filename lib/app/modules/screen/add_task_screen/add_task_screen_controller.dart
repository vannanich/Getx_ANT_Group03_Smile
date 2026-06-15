part of 'add_task_screen_view.dart';

class AddTaskScreenViewController extends GetxController {

  final titleController = TextEditingController();
  final descController = TextEditingController();
 
  final selectedPriority = Priority.medium.obs;
  final selectedDateTime = DateTime.now().obs;
  final tags = <String>[].obs;
 
  @override
  void onInit() {
    super.onInit();
  }
 
  @override
  void onClose() {
    titleController.dispose();
    descController.dispose();
    super.onClose();
  }
 
  // ── Getters ───────────────────────────────────────────────────────────────
 
  String get formattedDate {
    final d = selectedDateTime.value;
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[d.month]} ${d.day}, ${d.year}';
  }
 
  String get formattedTime {
    final d = selectedDateTime.value;
    final hour = d.hour > 12 ? d.hour - 12 : d.hour == 0 ? 12 : d.hour;
    final min = d.minute.toString().padLeft(2, '0');
    final period = d.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$min $period';
  }
 
  // ── Actions ───────────────────────────────────────────────────────────────
 
  Future<void> pickDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDateTime.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme:
              const ColorScheme.light(primary: Color(0xFF6C3CE1)),
        ),
        child: child!,
      ),
    );
    if (date == null) return;
 
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime.value),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme:
              const ColorScheme.light(primary: Color(0xFF6C3CE1)),
        ),
        child: child!,
      ),
    );
    if (time == null) return;
 
    selectedDateTime.value = DateTime(
      date.year, date.month, date.day, time.hour, time.minute,
    );
  }
 
  void removeTag(String tag) => tags.remove(tag);
 
  void showAddTagDialog() {
    final tagCtrl = TextEditingController();
    Get.dialog(
      AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Add tag',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        content: TextField(
          controller: tagCtrl,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'e.g. Health, Work…',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color(0xFF6C3CE1), width: 1.5),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel',
                style: TextStyle(color: Color(0xFFE74C3C))),
          ),
          ElevatedButton(
            onPressed: () {
              final t = tagCtrl.text.trim();
              if (t.isNotEmpty && !tags.contains(t)) tags.add(t);
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C3CE1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child:
                const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
 
  void addTask() {
    final title = titleController.text.trim();
    if (title.isEmpty) {
      Get.snackbar(
        'Missing title',
        'Please enter a task title.',
        backgroundColor: const Color(0xFFFDECEC),
        colorText: const Color(0xFFC0392B),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }
 
    Get.back(result: {
      'title': title,
      'subtitle': descController.text.trim().isEmpty
          ? 'No description'
          : descController.text.trim(),
      'priority': selectedPriority.value,
      'dateTime': selectedDateTime.value,
      'tags': tags.toList(),
    });
  }
}