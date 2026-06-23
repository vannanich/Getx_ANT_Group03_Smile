import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';
import 'package:get/get.dart';
import 'chat_with_doctor_controller.dart';

class ChatWithDoctorView extends GetView<ChatWithDoctorController> {
  const ChatWithDoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary, 
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildCategories(),
            Expanded(child: _buildDoctorList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 15,
                color: AppColors.secondary,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Chat with doctor',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                'Review your download book',
                style: TextStyle(fontSize: 12, color: AppColors.textLight),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
            ),
          ],
        ),
        child: TextField(
          onChanged: controller.onSearch,
          decoration: const InputDecoration(
            hintText: 'Search doctor...',
            hintStyle: TextStyle(color: AppColors.textLight, fontSize: 14),
            prefixIcon: Icon(Icons.search, color: AppColors.textLight),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return GetBuilder<ChatWithDoctorController>(
      builder: (controller) => SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: controller.categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, i) {
            final cat = controller.categories[i];
            final isSelected = controller.selectedCategory.value == cat;
            return GestureDetector(
              onTap: () => controller.selectCategory(cat),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.secondary : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Text(
                  cat,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : AppColors.textMid,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDoctorList() {
    return GetBuilder<ChatWithDoctorController>(
      builder: (controller) {
        final doctors = controller.filteredDoctors;
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          itemCount: doctors.length,
          itemBuilder: (_, i) => _buildDoctorCard(doctors[i]),
        );
      },
    );
  }

  Widget _buildDoctorCard(Doctor doctor) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Stack(
              children: [
                ClipOval(
                  child: Image.asset(
                    "assets/dr_profile.png",
                    width: 68,
                    height: 68,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 68,
                      height: 68,
                      color: AppColors.primary,
                      child: const Icon(
                        Icons.person,
                        color: AppColors.secondary,
                        size: 38,
                      ),
                    ),
                  ),
                ),
                // Verified badge
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.check, size: 11, color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 14),

            // ── Name, specialty, rating ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${doctor.specialty}   ${doctor.subSpecialty}',
                    style: const TextStyle(fontSize: 12, color: AppColors.textLight),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Color(0xFFFFC107), size: 16),
                      const SizedBox(width: 4),
                      Text(
                        doctor.rating.toString(),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        // ── Action row ──
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Get.toNamed(AppRoutes.bookAppointment),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Book an appointment',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Image(image: AssetImage("assets/message-2.png")),
            ),
          ],
        ),
      ],
    ),
  );
}
}