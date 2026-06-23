import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/doctor/d_homescreen/d_homescreen_controller.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';
import 'package:get/get.dart';

class DHomescreenView extends GetView<DHomescreenController> {
   DHomescreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(height: 16),
              _buildHeader(),
               SizedBox(height: 20),
              _buildOverviewCard(),
               SizedBox(height: 20),
              _buildTodayAppointment(),
               SizedBox(height: 20),
              _buildActionCards(),
               SizedBox(height: 24),
              _buildRecentPatients(),
               SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── Header ───────────────────────────────────────────────
  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primary,
          child: ClipOval(
            child: Image.network(
              'https://randomuser.me/api/portraits/men/32.jpg',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>  Icon(
                Icons.person,
                color: AppColors.secondary,
              ),
            ),
          ),
        ),
         SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.greeting,
                style:  TextStyle(
                  fontSize: 13,
                  color: AppColors.textLight,
                ),
              ),
              Text(
                controller.doctorName,
                style:  TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: controller.onNotificationTap,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child:  Icon(
              Icons.notifications_outlined,
              color: AppColors.secondary,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  // ── Overview Card ────────────────────────────────────────
  Widget _buildOverviewCard() {
    return Container(
      width: double.infinity,
      padding:  EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient:  LinearGradient(
          colors: [Color(0xFF7B4FE0), AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            top: -10,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: -20,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                     EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child:  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bar_chart, color: Colors.white, size: 14),
                    SizedBox(width: 4),
                    Text(
                      "Today's Overview",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
               SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${controller.totalAppointments}',
                        style:  TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                       SizedBox(height: 4),
                       Text(
                        'Total Appointments',
                        style: TextStyle(fontSize: 13, color: Colors.white70),
                      ),
                    ],
                  ),
                   Spacer(),
                  SizedBox(
                    width: 90,
                    height: 50,
                    child: CustomPaint(
                      painter: _LinePainter(controller.chartPoints),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTodayAppointment() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.dTodayAppoitment);
      },
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset:  Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child:  Icon(
                Icons.calendar_month_outlined,
                color: AppColors.secondary,
                size: 18,
              ),
            ),
             SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Today Appointment',
                    style: TextStyle(fontSize: 13, color: AppColors.textMid),
                  ),
                   SizedBox(height: 2),
                  Text(
                    '${controller.todayAppointments}',
                    style:  TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
             Icon(Icons.chevron_right, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCards() {
    return Row(
      children: [
        Expanded(
          child: _actionCard(
            icon: Icons.video_chat_rounded,
            iconBg: AppColors.primary,
            iconColor: AppColors.secondary,
            title: 'Post Video',
            subtitle: 'Record clip',
            onTap: controller.onPostVideoTap,
          ),
        ),
         SizedBox(width: 12),
        Expanded(
          child: _actionCard(
            icon: Icons.image_outlined,
            iconBg: AppColors.imageBackground,
            iconColor: AppColors.imageIcon,
            title: 'Post Image',
            subtitle: 'Share update',
            onTap: controller.onPostImageTap,
          ),
        ),
      ],
    );
  }

  Widget _actionCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:  EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset:  Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
             SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:  TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    subtitle,
                    style:  TextStyle(
                      fontSize: 11,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
             Icon(Icons.chevron_right,
                color: AppColors.textLight, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentPatients() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
              'Recent Patients',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.dTodayAppoitment);
              },
              child:  Text(
                'See all',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
         SizedBox(height: 14),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.patients.length,

            separatorBuilder: (_, __) =>  SizedBox(width: 12),
            itemBuilder: (context, i) {
              final p = controller.patients[i];

              return _patientCard(patient: p);
            },
          ),
        ),
      ],
    );
  }

Widget _patientCard({required PatientModel patient}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.dAppointmentDetail);
      },
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset:  Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                   BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                patient.image,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 100,
                  color: AppColors.primary,
                  child:  Icon(Icons.person, color: AppColors.secondary),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.name,
                    style:  TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    patient.subtitle,
                    style:  TextStyle(
                      fontSize: 10,
                      color: AppColors.textLight,
                    ),
                  ),
                   SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => controller.onMessageTap(patient),
                    child: Container(
                      padding:  EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:  Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Message',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 3),
                          Icon(Icons.chevron_right,
                              size: 12, color: AppColors.secondary),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Bottom Nav ───────────────────────────────────────────
  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:  BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset:  Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(index: 0, icon: Icons.home_outlined, label: 'Home'),
                _navItem(index: 1, icon: Icons.group_outlined, label: 'Patients'),
                _navItem(
                    index: 2, icon: Icons.chat, label: 'Chat'),
                _navItem(index: 3, icon: Icons.person_outline, label: 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = controller.selectedIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration:  Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: isSelected
            ?  EdgeInsets.symmetric(horizontal: 16, vertical: 8)
            :  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(24),
              )
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color:
                  isSelected ? AppColors.secondary : AppColors.textLight,
            ),
            if (isSelected && label.isNotEmpty) ...[
               SizedBox(width: 6),
              Text(
                label,
                style:  TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Mini Line Chart Painter ──────────────────────────────
class _LinePainter extends CustomPainter {
  final List<double> points;
  _LinePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    for (int i = 0; i < points.length; i++) {
      final x = (i / (points.length - 1)) * size.width;
      final y = size.height - (points[i] * size.height);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);

    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    for (int i = 0; i < points.length; i++) {
      final x = (i / (points.length - 1)) * size.width;
      final y = size.height - (points[i] * size.height);
      canvas.drawCircle(Offset(x, y), 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_LinePainter old) => old.points != points;
}