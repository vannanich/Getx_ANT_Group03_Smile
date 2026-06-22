// ignore_for_file: unnecessary_overrides

part of 'goal_screen_view.dart';

class GoalScreenController extends GetxController {
  final userName = 'Scott'.obs;
  final selectedDayIndex = 0.obs;
  final TextEditingController taskTextController = TextEditingController();

  final weekDays = [
    {'day': 'Mon', 'date': '12'},
    {'day': 'Tue', 'date': '13'},
    {'day': 'Wed', 'date': '14'},
    {'day': 'Thu', 'date': '15'},
    {'day': 'Fri', 'date': '16'},
    {'day': 'Sat', 'date': '17'},
    {'day': 'Sun', 'date': '18'},
  ];

  final tasks = <TaskModel>[
    TaskModel(
      title: 'Task 1',
      subtitle: 'Sleep 8 hours a day until you heal from your past',
      time: 'May 19, 10:43PM',
      isCompleted: true,
    ),
    TaskModel(
      title: 'Task 2',
      subtitle: 'Sleep 8 hours a day until you heal from your past',
      time: 'May 19, 10:20PM',
      isCompleted: true,
    ),
    TaskModel(
      title: 'Task 3',
      subtitle: 'Sleep 8 hours a day until you heal from your past',
      time: 'May 19, 10:00PM',
      isCompleted: false,
    ),
  ].obs;

  int get pendingCount => tasks.where((t) => !t.isCompleted).length;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    taskTextController.dispose();
    super.onClose();
  }

  void selectDay(int index) {
    selectedDayIndex.value = index;
  }

  // ── Navigate to Add Task screen ───────────────────────────────────────────

  Future<void> goToAddTask() async {
    final result = await Get.toNamed('/addtask');
    if (result == null) return;

    final data = result as Map<String, dynamic>;
    final now = DateTime.now();
    final timeStr = '${_monthName(now.month)} ${now.day}, ${_formatTime(now)}';

    tasks.add(TaskModel(
      title: data['title'] as String,
      subtitle: data['subtitle'] as String,
      time: timeStr,
      isCompleted: false,
    ));
  }

  // ── Navigate to Update Task screen ───────────────────────────────────────

  Future<void> goToUpdateTask(int index) async {
    final result = await Get.toNamed(
      '/updatetask',
      arguments: {'task': tasks[index], 'index': index},
    );
    if (result == null) return;

    final data = result as Map<String, dynamic>;

    // Handle delete
    if (data['deleted'] == true) {
      tasks.removeAt(index);
      return;
    }

    // Handle update
    final updated = TaskModel(
      title: data['title'] as String,
      subtitle: data['subtitle'] as String,
      time: tasks[index].time,
      isCompleted: data['isCompleted'] as bool? ?? tasks[index].isCompleted,
    );
    tasks[index] = updated;
    tasks.refresh();
  }

  void markComplete(int index) {
    tasks[index].isCompleted = true;
    tasks.refresh();
  }

  // ── Show task options bottom sheet ────────────────────────────────────────

  void showTaskOptions(int index) {
    final task = tasks[index];
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: Color(0xFFE0D9F5),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Text(
              task.title,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D2D2D)),
            ),
            SizedBox(height: 2),
            Text(
              task.time,
              style: TextStyle(fontSize: 12, color: Color(0xFF717182)),
            ),
            SizedBox(height: 18),
            if (!task.isCompleted) ...[
              _OptionTile(
                icon: Icons.check_rounded,
                iconBg: Color(0xFF27AE60),
                tileBg: Color(0xFFF0FFF5),
                borderColor: Color(0xFFA8E0B8),
                title: 'Mark as complete',
                subtitle: 'Mark this task done',
                titleColor: Color(0xFF1A7F3C),
                onTap: () {
                  Get.back();
                  showCompleteDialog(index);
                },
              ),
              SizedBox(height: 10),
            ],
            _OptionTile(
              icon: Icons.edit_outlined,
              iconBg: Color(0xFF6C3CE1),
              tileBg: Color(0xFFF5F3FC),
              borderColor: Color(0xFFEDE8FB),
              title: 'Edit task',
              subtitle: 'Modify this task',
              titleColor: Color(0xFF2D2D2D),
              onTap: () {
                Get.back();
                goToUpdateTask(index);
              },
            ),
            SizedBox(height: 10),
            _OptionTile(
              icon: Icons.delete_outline_rounded,
              iconBg: Color(0xFFE74C3C),
              tileBg: Color(0xFFFFF0F0),
              borderColor: Color(0xFFF5B5B5),
              title: 'Delete task',
              subtitle: 'Remove this task',
              titleColor: Color(0xFFC0392B),
              onTap: () {
                Get.back();
                showDeleteDialog(index);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  // ── Show complete dialog ──────────────────────────────────────────────────

  void showCompleteDialog(int index) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: const Text(
          'Are you sure? You have complete\nthis task.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Color(0xFF2D2D2D)),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFFE74C3C), fontSize: 15),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              markComplete(index);
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C3CE1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            ),
            child: const Text('Ok',
                style: TextStyle(color: Colors.white, fontSize: 15)),
          ),
        ],
      ),
    );
  }

  // ── Show delete dialog ────────────────────────────────────────────────────

  void showDeleteDialog(int index) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: const Text(
          'Are you sure you want to\ndelete this task?',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Color(0xFF2D2D2D)),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF6C3CE1), fontSize: 15),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              tasks.removeAt(index);
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE74C3C),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            ),
            child: const Text('Delete',
                style: TextStyle(color: Colors.white, fontSize: 15)),
          ),
        ],
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  String _monthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month];
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour > 12
        ? dt.hour - 12
        : dt.hour == 0
            ? 12
            : dt.hour;
    final min = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$min$period';
  }
}
