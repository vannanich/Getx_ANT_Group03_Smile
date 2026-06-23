import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/core/themes/theme_controller.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:get/get.dart';

part 'notification_screen_binding.dart';
part 'notification_screen_controller.dart';

class NotificationScreenView extends GetView<NotificationScreenViewController> {
  const NotificationScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Get.find<ThemeController>().isDarkMode.value;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F0E1A) : const Color(0xFFEEECF5),
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF0F0E1A) : const Color(0xFFEEECF5),
        toolbarHeight: 70,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notification",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black)),
            SizedBox(height: 4),
            Text("Review your notification",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF9F9DA4))),
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: controller.notifications.length,
        itemBuilder: (context, index) {
          final notif = controller.notifications[index];
          return _buildNotificationItem(notif, isDark);
        },
      ),
    );
  }

  Widget _buildNotificationItem(NotificationModel notif, bool isDark) {
    return GestureDetector(
      onTap: () => controller.onNotificationTap(notif),
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1C1A2E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF0F0E1A) : const Color(0xFFEEECF5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                notif.icon == Icons.chat_bubble_outline
                    ? "assets/message.png"
                    : "assets/notif.png",
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notif.title,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black)),
                  SizedBox(height: 4),
                  Text(notif.subtitle,
                      style: TextStyle(
                          fontSize: 13,
                          color: const Color(0xFF9F9DA4),
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Text(notif.time,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: const Color(0xFF9F9DA4))),
          ],
        ),
      ),
    );
  }
}