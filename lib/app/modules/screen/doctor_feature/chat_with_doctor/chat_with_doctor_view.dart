import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'chat_with_doctor_controller.dart';

class ChatWithDoctorView extends GetView<ChatWithDoctorController> {
   ChatWithDoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFF4F0FF),
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
      padding:  EdgeInsets.fromLTRB(20, 16, 20, 8),
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
                    offset:  Offset(0, 2),
                  ),
                ],
              ),
              child:  Icon(Icons.arrow_back_ios_new, size: 15, color: Color(0xFF6B3FD4)),
            ),
          ),
           SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(
                'Chat with doctor',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2D1B6B),
                ),
              ),
              Text(
                'Review your download book',
                style: TextStyle(fontSize: 12, color: Color(0xFF9B8AB8)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
          ],
        ),
        child: TextField(
          onChanged: controller.onSearch,
          decoration:  InputDecoration(
            hintText: 'Search doctor...',
            hintStyle: TextStyle(color: Color(0xFF9B8AB8), fontSize: 14),
            prefixIcon: Icon(Icons.search, color: Color(0xFF9B8AB8)),
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
        padding:  EdgeInsets.symmetric(horizontal: 20),
        itemCount: controller.categories.length,
        separatorBuilder: (_, __) =>  SizedBox(width: 8),
        itemBuilder: (_, i) {
          final cat = controller.categories[i];
          final isSelected = controller.selectedCategory.value == cat;
          return GestureDetector(
            onTap: () => controller.selectCategory(cat),
            child: AnimatedContainer(
              duration:  Duration(milliseconds: 200),
              padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ?  Color(0xFF6B3FD4) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
                ],
              ),
              child: Text(
                cat,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white :  Color(0xFF9B8AB8),
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
        padding:  EdgeInsets.all(20),
        itemCount: doctors.length,
        itemBuilder: (_, i) => _buildDoctorCard(doctors[i]),
      );
    },
  );
}

  Widget _buildDoctorCard(Doctor doctor) {
    return Container(
      margin:  EdgeInsets.only(bottom: 16),
      padding:  EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset:  Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      doctor.imagePath,
                      width: 65,
                      height: 65,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          color:  Color(0xFFE8E0FF),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child:  Icon(Icons.person, color: Color(0xFF6B3FD4), size: 36),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color:  Color(0xFF6B3FD4),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child:  Icon(Icons.check, size: 11, color: Colors.white),
                    ),
                  ),
                ],
              ),
               SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style:  TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2D1B6B),
                      ),
                    ),
                     SizedBox(height: 3),
                    Text(
                      '${doctor.specialty}  ${doctor.subSpecialty}',
                      style:  TextStyle(fontSize: 12, color: Color(0xFF9B8AB8)),
                    ),
                     SizedBox(height: 4),
                    Row(
                      children: [
                         Icon(Icons.star_rounded, color: Color(0xFFFFC107), size: 16),
                         SizedBox(width: 4),
                        Text(
                          doctor.rating.toString(),
                          style:  TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D1B6B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
           SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.toNamed(AppRoutes.bookAppointment);                    
                  },
                  icon:  SizedBox(),
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.bookAppointment);
                        },
                        child: Text(
                          'Book an appointment',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color(0xFF5B2DC4),
                    padding:  EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                ),
              ),
               SizedBox(width: 10),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color:  Color(0xFFF4F0FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  Icon(Icons.chat_bubble_outline_rounded, color: Color(0xFF6B3FD4), size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}