import 'package:get/get.dart';

class DoctorAppointmentController extends GetxController {
  final doctorName = 'Dr. Tung Tung Sahur'.obs;
  final specialty = 'Therapist'.obs;
  final subSpecialty = 'Psychologists'.obs;
  final rating = 4.5.obs;
  final reviews = '7.4k Reviews'.obs;
  final experiences = '5+'.obs;
  final imagePath = 'assets/images/doctor.jpg'.obs;
  final about =
      'Dr. Tung Tung Shahur Carter specializes in anxiety disorders, depression, stress management, trauma recovery, and relationship counseling. She focuses on creating a safe and supportive environment where patients can openly discuss their emotional and psychological challenges.'
          .obs;

  void onMessage() {
    // handle message
  }

  void onBookAppointment() {
    // handle booking
  }
}