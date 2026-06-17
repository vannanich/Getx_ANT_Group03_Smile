class TaskModel {
  final String title;
  final String subtitle;
  final String time;
  bool isCompleted;

  TaskModel({
    required this.title,
    required this.subtitle,
    required this.time,
    this.isCompleted = false,
  });
}