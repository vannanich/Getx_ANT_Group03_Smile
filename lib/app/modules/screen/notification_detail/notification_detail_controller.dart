part of 'notification_detail_view.dart';

class NotificationDetailViewController extends GetxController {
  late NotificationModel notif;

  final selectedHour = 7.obs;
  final selectedMinute = 35.obs;
  final isSelectingHour = true.obs;

  @override
  void onInit() {
    super.onInit();
    notif = Get.arguments as NotificationModel;
    selectedHour.value = notif.appointmentDate?.hour ?? 7;
    selectedMinute.value = notif.appointmentDate?.minute ?? 0;
  }

  void onClockDrag(Offset localPos, Size clockSize) {
    final center = Offset(clockSize.width / 2, clockSize.height / 2);
    final dx = localPos.dx - center.dx;
    final dy = localPos.dy - center.dy;

    double angle = math.atan2(dy, dx);
    double degrees = (angle * 180 / math.pi + 90 + 360) % 360;

    if (isSelectingHour.value) {
      int raw = (degrees / 30).round() % 12;
      final ispm = selectedHour.value >= 12;
      selectedHour.value = ispm ? raw + 12 : raw;
    } else {
      selectedMinute.value = ((degrees / 6).round()) % 60;
    }
  }

  void setAM() {
    if (selectedHour.value >= 12) {
      selectedHour.value = selectedHour.value - 12;
    }
  }

  void setPM() {
    if (selectedHour.value < 12) {
      selectedHour.value = selectedHour.value + 12;
    }
  }

  void incrementHour() => selectedHour.value = (selectedHour.value + 1) % 24;
  void decrementHour() =>
      selectedHour.value = (selectedHour.value - 1 + 24) % 24;
  void incrementMinute() =>
      selectedMinute.value = (selectedMinute.value + 1) % 60;
  void decrementMinute() =>
      selectedMinute.value = (selectedMinute.value - 1 + 60) % 60;

  String monthName(int month) {
    const months = [
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
    return months[month - 1];
  }
}
