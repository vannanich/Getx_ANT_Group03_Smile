import 'package:get/get.dart';

class AppointmentModel {
  final int? id;
  final String patientName;
  final String patientImage;
  final String time;
  final String type; // 'Video Call' or 'Chat'
  final String status; // 'upcoming' | 'completed' | 'cancelled'
  final String subtitle;

  AppointmentModel({
    this.id,
    required this.patientName,
    required this.patientImage,
    required this.time,
    required this.type,
    required this.status,
    required this.subtitle,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      patientName: json['patient_name'] ?? '',
      patientImage: json['patient_image'] ?? '',
      time: json['time'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      subtitle: json['subtitle'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient_name': patientName,
      'patient_image': patientImage,
      'time': time,
      'type': type,
      'status': status,
      'subtitle': subtitle,
    };
  }
}

class DTodayAppoitmentController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString selectedFilter = 'All'.obs;
  final RxList<AppointmentModel> appointments = <AppointmentModel>[].obs;

  final List<String> filters = ['All', 'Upcoming', 'Completed', 'Cancelled'];

  final List<AppointmentModel> _dummyAppointments = [
    AppointmentModel(
      id: 1,
      patientName: 'Cooper, Kristin',
      patientImage: 'https://randomuser.me/api/portraits/women/44.jpg',
      time: '09:00 AM',
      type: 'Video Call',
      status: 'upcoming',
      subtitle: 'Cardio follow up',
    ),
    AppointmentModel(
      id: 2,
      patientName: 'Flores, Juanita',
      patientImage: 'https://randomuser.me/api/portraits/women/68.jpg',
      time: '10:30 AM',
      type: 'Chat',
      status: 'upcoming',
      subtitle: 'General checkup',
    ),
    AppointmentModel(
      id: 3,
      patientName: 'Henry, James',
      patientImage: 'https://randomuser.me/api/portraits/men/45.jpg',
      time: '12:00 PM',
      type: 'Video Call',
      status: 'completed',
      subtitle: 'Blood pressure review',
    ),
    AppointmentModel(
      id: 4,
      patientName: 'Dara Pich',
      patientImage: 'https://randomuser.me/api/portraits/men/32.jpg',
      time: '02:00 PM',
      type: 'Chat',
      status: 'cancelled',
      subtitle: 'Mental health session',
    ),
    AppointmentModel(
      id: 5,
      patientName: 'Sreymom Chan',
      patientImage: 'https://randomuser.me/api/portraits/women/22.jpg',
      time: '03:30 PM',
      type: 'Video Call',
      status: 'upcoming',
      subtitle: 'Anxiety follow up',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    loadAppointments();
  }

  // ── Load (swap with API call later) ───────────────────
  Future<void> loadAppointments() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 500)); // remove when using FastAPI
      appointments.assignAll(_dummyAppointments);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load appointments');
    } finally {
      isLoading.value = false;
    }
  }

  // ── FastAPI (uncomment when ready) ────────────────────
  // Future<void> loadAppointments() async {
  //   try {
  //     isLoading.value = true;
  //     final response = await dio.get('/appointments/today');
  //     appointments.value = (response.data as List)
  //         .map((json) => AppointmentModel.fromJson(json))
  //         .toList();
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to load appointments');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // ── Filtered list ──────────────────────────────────────
  List<AppointmentModel> get filteredAppointments {
    if (selectedFilter.value == 'All') return appointments;
    return appointments
        .where((a) =>
            a.status.toLowerCase() ==
            selectedFilter.value.toLowerCase())
        .toList();
  }

  // ── Actions ────────────────────────────────────────────
  void selectFilter(String filter) {
    selectedFilter.value = filter;
  }

  void onAppointmentTap(AppointmentModel appointment) {
    // TODO: Get.toNamed('/appointment-detail', arguments: appointment);
  }

  void onStartCall(AppointmentModel appointment) {
    // TODO: Get.toNamed('/video-call', arguments: appointment);
  }

  void onStartChat(AppointmentModel appointment) {
    // TODO: Get.toNamed('/chat', arguments: appointment);
  }
}