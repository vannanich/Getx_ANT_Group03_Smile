import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/d_homescreen/d_today_appoitment/d_today_appoitment_controller.dart';
import 'package:flutter_application_1/app/shared/themes/app_colors.dart';
import 'package:get/get.dart';


class DTodayAppoitmentView extends GetView<DTodayAppoitmentController> {
  const DTodayAppoitmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildFilterTabs(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.secondary,
                  ),
                );
              }

              if (controller.filteredAppointments.isEmpty) {
                return _buildEmpty();
              }

              return RefreshIndicator(
                color: AppColors.secondary,
                onRefresh: controller.loadAppointments,
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.filteredAppointments.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final appointment =
                        controller.filteredAppointments[i];
                    return _appointmentCard(appointment);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ── AppBar ─────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.secondary,
            size: 16,
          ),
        ),
      ),
      title: const Text(
        'Today Appointment',
        style: TextStyle(
          color: AppColors.textDark,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      actions: [
        Obx(() => Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: AppColors.secondary,
                    size: 18,
                  ),
                ),
              ],
            )),
        const SizedBox(width: 4),
      ],
    );
  }

  // ── Filter Tabs ────────────────────────────────────────
  Widget _buildFilterTabs() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Obx(
        () => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: controller.filters.map((filter) {
              final isSelected = controller.selectedFilter.value == filter;
              return GestureDetector(
                onTap: () => controller.selectFilter(filter),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.secondary
                        : AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    filter,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : AppColors.secondary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // ── Appointment Card ───────────────────────────────────
  Widget _appointmentCard(AppointmentModel appointment) {
    return GestureDetector(
      onTap: () => controller.onAppointmentTap(appointment),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // ── Avatar ──────────────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                appointment.patientImage,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 56,
                  height: 56,
                  color: AppColors.primary,
                  child: const Icon(
                    Icons.person,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // ── Info ────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.patientName,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    appointment.subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Time
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 12,
                              color: AppColors.secondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              appointment.time,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Type
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: appointment.type == 'Video Call'
                              ? AppColors.imageBackground
                              : AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              appointment.type == 'Video Call'
                                  ? Icons.videocam_outlined
                                  : Icons.chat_bubble_outline,
                              size: 12,
                              color: appointment.type == 'Video Call'
                                  ? AppColors.imageIcon
                                  : AppColors.secondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              appointment.type,
                              style: TextStyle(
                                fontSize: 11,
                                color: appointment.type == 'Video Call'
                                    ? AppColors.imageIcon
                                    : AppColors.secondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // ── Status + Action ──────────────────────────
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _statusBadge(appointment.status),
                const SizedBox(height: 8),
                if (appointment.status == 'upcoming')
                  _actionButton(appointment),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Status Badge ───────────────────────────────────────
  Widget _statusBadge(String status) {
    Color bg;
    Color text;
    String label;

    switch (status.toLowerCase()) {
      case 'upcoming':
        bg = AppColors.primary;
        text = AppColors.secondary;
        label = 'Upcoming';
        break;
      case 'completed':
        bg = const Color(0xFFECFDF5);
        text = const Color(0xFF059669);
        label = 'Completed';
        break;
      case 'cancelled':
        bg = AppColors.pdfBackground;
        text = AppColors.pdfIcon;
        label = 'Cancelled';
        break;
      default:
        bg = AppColors.primary;
        text = AppColors.secondary;
        label = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
    );
  }

  // ── Action Button ──────────────────────────────────────
  Widget _actionButton(AppointmentModel appointment) {
    final isVideo = appointment.type == 'Video Call';
    return GestureDetector(
      onTap: () => isVideo
          ? controller.onStartCall(appointment)
          : controller.onStartChat(appointment),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              isVideo ? Icons.videocam : Icons.chat_bubble,
              size: 12,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Text(
              isVideo ? 'Start' : 'Chat',
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Empty State ────────────────────────────────────────
  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              color: AppColors.secondary,
              size: 36,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No Appointments',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'No appointments found\nfor this filter.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}