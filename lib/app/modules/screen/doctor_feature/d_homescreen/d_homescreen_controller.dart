// // lib/controllers/doctor_home_controller.dart

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class DoctorHomeController extends GetxController {
//   // ── Navigation ────────────────────────────────────────────────────────────
//   final RxInt currentIndex = 0.obs;

//   // ── Doctor info (replace with real data from API/auth) ────────────────────
//   final RxString doctorName = 'Dr. Sophea Noun'.obs;
//   final RxString specialty = 'Psychiatrist / Mental Health'.obs;
//   final RxString profileImage = ''.obs;
//   final RxBool isVerified = true.obs;

//   // ── Stats ─────────────────────────────────────────────────────────────────
//   final RxInt totalPatients = 128.obs;
//   final RxInt totalAppointments = 24.obs;
//   final RxInt totalPosts = 47.obs;
//   final RxDouble rating = 4.8.obs;

//   // ── Appointments ──────────────────────────────────────────────────────────
//   final RxList<Map<String, dynamic>> appointments = <Map<String, dynamic>>[
//     {
//       'name': 'Dara Pich',
//       'time': '09:00 AM',
//       'type': 'Video Call',
//       'status': 'upcoming',
//       'avatar': 'D',
//       'color': 0xFF6366F1,
//     },
//     {
//       'name': 'Sreymom Chan',
//       'time': '10:30 AM',
//       'type': 'Chat',
//       'status': 'upcoming',
//       'avatar': 'S',
//       'color': 0xFFEC4899,
//     },
//     {
//       'name': 'Visal Keo',
//       'time': '02:00 PM',
//       'type': 'Video Call',
//       'status': 'upcoming',
//       'avatar': 'V',
//       'color': 0xFF10B981,
//     },
//     {
//       'name': 'Kolab Ros',
//       'time': '03:30 PM',
//       'type': 'Chat',
//       'status': 'completed',
//       'avatar': 'K',
//       'color': 0xFFF59E0B,
//     },
//   ].obs;

//   // ── Recent chats ──────────────────────────────────────────────────────────
//   final RxList<Map<String, dynamic>> recentChats = <Map<String, dynamic>>[
//     {
//       'name': 'Dara Pich',
//       'message': 'Thank you doctor, I feel much better!',
//       'time': '10 min ago',
//       'unread': 2,
//       'avatar': 'D',
//       'color': 0xFF6366F1,
//     },
//     {
//       'name': 'Sreymom Chan',
//       'message': 'Can we reschedule to tomorrow?',
//       'time': '1 hr ago',
//       'unread': 1,
//       'avatar': 'S',
//       'color': 0xFFEC4899,
//     },
//     {
//       'name': 'Visal Keo',
//       'message': 'I have been following the routine.',
//       'time': '2 hr ago',
//       'unread': 0,
//       'avatar': 'V',
//       'color': 0xFF10B981,
//     },
//     {
//       'name': 'Kolab Ros',
//       'message': 'Feeling anxious again today...',
//       'time': 'Yesterday',
//       'unread': 0,
//       'avatar': 'K',
//       'color': 0xFFF59E0B,
//     },
//   ].obs;

//   // ── Posts ─────────────────────────────────────────────────────────────────
//   final RxList<Map<String, dynamic>> posts = <Map<String, dynamic>>[
//     {
//       'title': 'Managing Anxiety Daily',
//       'content':
//           'Start your morning with 5 minutes of deep breathing. It helps regulate your nervous system and sets a calm tone for the day.',
//       'likes': 142,
//       'comments': 28,
//       'time': '2 hours ago',
//       'tag': 'Mental Health',
//       'tagColor': 0xFF6366F1,
//       'liked': false,
//     },
//     {
//       'title': 'The Power of Gratitude',
//       'content':
//           'Writing 3 things you are grateful for every night has been shown to significantly improve mood and sleep quality over time.',
//       'likes': 98,
//       'comments': 15,
//       'time': 'Yesterday',
//       'tag': 'Wellness',
//       'tagColor': 0xFF10B981,
//       'liked': true,
//     },
//     {
//       'title': 'You Are Not Alone',
//       'content':
//           'Mental health struggles are more common than you think. Reaching out is a sign of strength, not weakness.',
//       'likes': 215,
//       'comments': 42,
//       'time': '2 days ago',
//       'tag': 'Motivation',
//       'tagColor': 0xFFF59E0B,
//       'liked': false,
//     },
//   ].obs;

//   // ── Analytics data ────────────────────────────────────────────────────────
//   final RxList<double> weeklyPatients = <double>[12, 18, 15, 22, 19, 25, 20].obs;
//   final RxList<String> weekDays = <String>['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].obs;

//   void changePage(int index) => currentIndex.value = index;

//   void toggleLike(int index) {
//     final post = Map<String, dynamic>.from(posts[index]);
//     post['liked'] = !post['liked'];
//     post['likes'] = post['liked'] ? post['likes'] + 1 : post['likes'] - 1;
//     posts[index] = post;
//   }

//   void logout() {
//     Get.offAllNamed('/login');
//   }
// }

import 'package:get/get.dart';

class PatientModel {
  final String name;
  final String image;

  PatientModel({
    required this.name,
    required this.image,
  });
}

class DHomescreenController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxBool hasNotification = true.obs;

  List<PatientModel> patients = [
    PatientModel(
      name: "Cooper, Kristin",
      image:
          "https://randomuser.me/api/portraits/women/44.jpg",
    ),
    PatientModel(
      name: "Flores, Juanita",
      image:
          "https://randomuser.me/api/portraits/women/68.jpg",
    ),
    PatientModel(
      name: "Henry, James",
      image:
          "https://randomuser.me/api/portraits/men/32.jpg",
    ),
  ];
}