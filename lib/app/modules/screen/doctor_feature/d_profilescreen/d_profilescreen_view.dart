import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'd_profilescreen_binding.dart';
part 'd_profilescreen_controller.dart';

class DProfilescreenView extends GetView<DProfilescreenViewController> {
  const DProfilescreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 20),
              _buildCerti(),
              SizedBox(height: 20),
              _buildCard(),
              SizedBox(height: 35),
              Text(
                'Clinic Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              SizedBox(height: 14),
              _InfoCard(
                label: 'Location',
                value: 'Phnom Penh Medical Center',
              ),
              SizedBox(height: 10),
              _InfoCard(
                label: 'Time',
                value: 'Mon - Fri, 8AM - 5PM',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdjLlJS2C2KD-fRoOykz8e5luqOtFFpGo_QQ&s',
              ),
              backgroundColor: Colors.grey.shade300,
            ),
            SizedBox(width: 12),
            // Greeting + Name
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4B4B4B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Dr. Lili',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Color(0xFF6C5CE7),
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            "assets/location.png",
          ),
        ),
      ],
    );
  }

  Widget _buildCerti() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Color(0xFFFDF6E3),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Image.asset(
                "assets/verify.png",
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '5+',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFEBD405),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Certificate',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4B4B4B),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildStatCard({
  required Color backgroundColor,
  required Color textColor,
  required String imagePath,
  required String number,
  required String title,
}) {
  return Container(
    height: 170,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: 70,
          height: 70,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 16),
        Text(
          number,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xff4B4B4B),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCard() {
  return Row(
    children: [
      Expanded(
        child: _buildStatCard(
          backgroundColor: Color(0xFFE6DAFE),
          textColor: Color(0xFF5B2BE0),
          imagePath: "assets/microscope_svgrepo.png",
          number: "5+",
          title: "Experiences",
        ),
      ),
      SizedBox(width: 20),
      Expanded(
        child: _buildStatCard(
          backgroundColor: Color(0xFFF1F8F4),
          textColor: Color(0xFF31C15B),
          imagePath: "assets/patient_people.png",
          number: "100+",
          title: "Patients",
        ),
      ),
    ],
  );
}

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;

  const _InfoCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF7E7E7E),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4B4B4B),
            ),
          ),
        ],
      ),
    );
  }
}
