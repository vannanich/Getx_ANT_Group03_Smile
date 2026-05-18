import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/book_appointment/book_appointment_controller.dart';
import 'package:get/get.dart';

class DoctorAppointmentView extends GetView<DoctorAppointmentController> {
  const DoctorAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F0FF),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDoctorInfo(),
                  _buildStats(),
                  _buildMessageButton(),
                  _buildAbout(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBookButton(),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 260,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF8B5CF6),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // back button
            Positioned(
              top: 10,
              left: 20,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // title
            Positioned(
              top: 10,
              left: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Doctor Appointment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Contact the doctor for an appointment',
                    style: TextStyle(fontSize: 11, color: Colors.white70),
                  ),
                ],
              ),
            ),
            // doctor image
            Positioned(
              bottom: 0,
              child: GetBuilder<DoctorAppointmentController>(
                builder: (controller) => ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    controller.imagePath.value,
                    width: 130,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 130,
                      height: 150,
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return GetBuilder<DoctorAppointmentController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.doctorName.value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2D1B6B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${controller.specialty.value}  —  ${controller.subSpecialty.value}',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF9B8AB8),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStatCard(
                    controller.rating.value.toString(),
                    controller.reviews.value,
                    icon: Icons.star_rounded,
                    iconColor: const Color(0xFFFFC107),
                  ),
                  const SizedBox(width: 12),
                  _buildStatCard(
                    '',
                    'Verified badge',
                    icon: Icons.verified,
                    iconColor: const Color(0xFF6B3FD4),
                  ),
                  const SizedBox(width: 12),
                  _buildStatCard(
                    controller.experiences.value,
                    'Experiences',
                    icon: null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String value,
    String label, {
    IconData? icon,
    Color? iconColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F0FF),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            if (icon != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (value.isNotEmpty)
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2D1B6B),
                      ),
                    ),
                  const SizedBox(width: 4),
                  Icon(icon, color: iconColor, size: 20),
                ],
              )
            else
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2D1B6B),
                ),
              ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Color(0xFF9B8AB8)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats() {
    return const SizedBox();
  }

  Widget _buildMessageButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: OutlinedButton.icon(
        onPressed: controller.onMessage,
        icon: const Icon(
          Icons.chat_bubble_outline_rounded,
          color: Color(0xFF6B3FD4),
          size: 18,
        ),
        label: const Text(
          'Message',
          style: TextStyle(
            color: Color(0xFF6B3FD4),
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 52),
          side: const BorderSide(color: Color(0xFF6B3FD4), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  Widget _buildAbout() {
    return GetBuilder<DoctorAppointmentController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2D1B6B),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              controller.about.value,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF9B8AB8),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 36),
      child: ElevatedButton(
        onPressed: controller.onBookAppointment,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 52),
          backgroundColor: const Color(0xFF5B2DC4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 4,
          shadowColor: const Color(0xFF5B2DC4).withOpacity(0.35),
        ),
        child: const Text(
          'Book an appointment',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}