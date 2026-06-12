import 'package:get/get.dart';

class PatientModel {
  final String name;
  final String subtitle;
  final String image;

  PatientModel({
    required this.name,
    required this.subtitle,
    required this.image,
  });
}

class DHomescreenController extends GetxController {
  // ── Navigation ─────────────────────────────────────────
  final RxInt selectedIndex = 0.obs;

  // ── Notification ───────────────────────────────────────
  final RxBool hasNotification = true.obs;

  // ── Doctor Info ────────────────────────────────────────
  final String greeting = 'Good morning,';
  final String doctorName = 'Dr. Latte Latte';
  final String avatarUrl =
      'https://randomuser.me/api/portraits/men/32.jpg';

  // ── Stats ──────────────────────────────────────────────
  final int totalAppointments = 12;
  final int todayAppointments = 12;

  // ── Chart Points ───────────────────────────────────────
  final List<double> chartPoints = [
    0.6, 0.3, 0.7, 0.4, 0.8, 0.5, 0.9,
  ];

  // ── Recent Patients ────────────────────────────────────
  final List<PatientModel> patients = [
    PatientModel(
      name: 'Cooper, Kristin',
      subtitle: 'Cardio follow up',
      image: 'https://randomuser.me/api/portraits/women/44.jpg',
    ),
    PatientModel(
      name: 'Flores, Juanita',
      subtitle: 'Cardio follow up',
      image: 'https://randomuser.me/api/portraits/women/68.jpg',
    ),
    PatientModel(
      name: 'Henry, James',
      subtitle: 'Cardio',
      image: 'https://randomuser.me/api/portraits/men/45.jpg',
    ),
  ];

  // ── Actions ────────────────────────────────────────────
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void onNotificationTap() {
    hasNotification.value = false;
    // TODO: Get.toNamed('/notifications');
  }

  void onAppointmentTap() {
    // TODO: Get.toNamed('/appointments');
  }

  void onPostVideoTap() {
    // TODO: Get.toNamed('/post-video');
  }

  void onPostImageTap() {
    // TODO: Get.toNamed('/post-image');
  }

  void onSeeAllPatients() {
    // TODO: Get.toNamed('/patients');
  }

  void onMessageTap(PatientModel patient) {
    // TODO: Get.toNamed('/chat', arguments: patient);
  }
}