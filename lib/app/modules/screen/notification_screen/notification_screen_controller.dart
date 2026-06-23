part of 'notification_screen_view.dart';

class NotificationModel {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final bool hasDetail;
  final DateTime? appointmentDate;

  NotificationModel({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    this.hasDetail = false,
    this.appointmentDate,
  });
}

class NotificationScreenViewController extends GetxController {
  
  final notifications = <NotificationModel>[
    NotificationModel(
      title: "Dr.TungTung Sahur",
      subtitle: "Appointment approved",
      time: "11:11pm",
      icon: Icons.notifications_outlined,
      hasDetail: true,
      appointmentDate: DateTime(2026, 1, 12, 7, 35),
    ),
    NotificationModel(
      title: "Dr.TungTung Sahur",
      subtitle: "Replied to your message",
      time: "11:11pm",
      icon: Icons.chat_bubble_outline,
    ),
    NotificationModel(
      title: "Dr.TungTung Sahur",
      subtitle: "Appointment approved",
      time: "11:11pm",
      icon: Icons.notifications_outlined,
      hasDetail: true,
      appointmentDate: DateTime(2026, 1, 12, 7, 35),
    ),
    NotificationModel(
      title: "Dr.TungTung Sahur",
      subtitle: "Appointment approved",
      time: "11:11pm",
      icon: Icons.notifications_outlined,
      hasDetail: true,
      appointmentDate: DateTime(2026, 1, 12, 7, 35),
    ),
  ];

  void onNotificationTap(NotificationModel notif) {
    if (notif.hasDetail && notif.appointmentDate != null) {
      Get.toNamed(
        AppRoutes.notificationDetail,
        arguments: notif,
      );
    }
  }
}
