// ignore_for_file: use_build_context_synchronously

part of 'update_task_screen_view.dart';

class UpdateTaskScreenViewController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController descController;

  final selectedStatus = TaskStatus.todo.obs;
  final selectedPriority = Priority.medium.obs;
  final pickedDateTime = Rxn<DateTime>();
  final tags = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    descController = TextEditingController();

    final args = Get.arguments;
    if (args != null) {
      final task = args['task'] as TaskModel;
      titleController.text = task.title;
      descController.text = task.subtitle;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descController.dispose();
    super.onClose();
  }

  String get formattedDate {
    if (pickedDateTime.value == null) return 'Select date';
    final d = pickedDateTime.value!;
    return '${d.day}/${d.month}/${d.year}';
  }

  String get formattedTime {
    if (pickedDateTime.value == null) return '';
    final d = pickedDateTime.value!;
    final h = d.hour.toString().padLeft(2, '0');
    final m = d.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  Future<void> pickDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: pickedDateTime.value ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay.fromDateTime(pickedDateTime.value ?? DateTime.now()),
    );
    if (time == null) return;

    pickedDateTime.value = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  void removeTag(String tag) => tags.remove(tag);

  void showAddTagDialog() {
    final input = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text('Add tag'),
        content: TextField(
          controller: input,
          decoration: const InputDecoration(hintText: 'Tag name'),
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              final val = input.text.trim();
              if (val.isNotEmpty) tags.add(val);
              Get.back();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void showDeleteDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              Get.back(result: {'deleted': true});
            },
            child: const Text('Delete',
                style: TextStyle(color: Color(0xFFC0392B))),
          ),
        ],
      ),
    );
  }

  void saveTask() {
    if (titleController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Title is required',
          backgroundColor: const Color(0xFFFFEBEB),
          colorText: const Color(0xFFC0392B));
      return;
    }

    Get.back(result: {
      'title': titleController.text.trim(),
      'subtitle': descController.text.trim().isEmpty
          ? 'No description'
          : descController.text.trim(),
      'isCompleted': selectedStatus.value == TaskStatus.done,
    });
  }
}
