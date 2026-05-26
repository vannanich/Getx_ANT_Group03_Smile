// lib/views/id_scan_view.dart

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/models/khmer_id.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/scan_id/scan_doctor_id/scan_doctor_id_controller.dart';
import 'package:flutter_application_1/app/widgets/scan_overlay.dart';
import 'package:get/get.dart';

class ScanDoctorIdView extends GetView<ScanDoctorIdController> {
  const ScanDoctorIdView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        switch (controller.scanState.value) {
          case ScanState.processing:
          case ScanState.success:
            return _buildResultScreen(context);
          case ScanState.error:
            return _buildErrorScreen(context);
          default:
            return _buildCameraScreen(context);
        }
      }),
    );
  }

  // ── 1. Camera screen ────────────────────────────────────────────────────
  Widget _buildCameraScreen(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Camera preview
        Obx(() {
          if (!controller.isCameraReady.value) {
            return _buildCameraLoading();
          }
          return ClipRect(
            child: OverflowBox(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controller
                      .cameraController!.value.previewSize!.height,
                  height:
                      controller.cameraController!.value.previewSize!.width,
                  child: CameraPreview(controller.cameraController!),
                ),
              ),
            ),
          );
        }),

        // Card frame overlay
        Obx(() => ScanOverlayWidget(progress: controller.scanProgress.value)),

        // Top bar
        _buildTopBar(),

        // Bottom controls
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SafeArea(child: _buildBottomControls()),
        ),
      ],
    );
  }

  Widget _buildCameraLoading() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Color(0xFF60A5FA),
            ),
            const SizedBox(height: 16),
            Obx(
              () => Text(
                controller.errorMessage.value.isEmpty
                    ? 'Starting camera…'
                    : controller.errorMessage.value,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 20),
            ),
            const Expanded(
              child: Text(
                'Scan Khmer ID Card',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Obx(
              () => IconButton(
                onPressed: controller.toggleFlash,
                icon: Icon(
                  controller.isFlashOn.value
                      ? Icons.flash_on_rounded
                      : Icons.flash_off_rounded,
                  color: controller.isFlashOn.value
                      ? const Color(0xFFFBBF24)
                      : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withOpacity(0.9),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Shutter button
          Obx(
            () => GestureDetector(
              onTap: controller.isCameraReady.value
                  ? controller.captureAndScan
                  : null,
              child: Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFF60A5FA),
                    width: 3.5,
                  ),
                ),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  size: 34,
                  color: Color(0xFF1D4ED8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Tap to capture',
            style: TextStyle(color: Colors.white38, fontSize: 12),
          ),
          const SizedBox(height: 16),
          // Gallery fallback
          OutlinedButton.icon(
            onPressed: controller.pickFromGallery,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white70,
              side: const BorderSide(color: Colors.white24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            icon: const Icon(Icons.photo_library_outlined, size: 18),
            label: const Text('Upload from gallery'),
          ),
        ],
      ),
    );
  }

  // ── 2. Processing / Success screen ──────────────────────────────────────
  Widget _buildResultScreen(BuildContext context) {
    return Obx(() {
      final isSuccess =
          controller.scanState.value == ScanState.success;

      return SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  if (!isSuccess)
                    IconButton(
                      onPressed: controller.retry,
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  const Spacer(),
                  Text(
                    isSuccess ? 'ID Verified' : 'Reading ID…',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  if (!isSuccess) const SizedBox(width: 48),
                ],
              ),
            ),

            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Status icon
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: isSuccess
                            ? Container(
                                key: const ValueKey('success'),
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF4ADE80)
                                      .withOpacity(0.15),
                                  border: Border.all(
                                    color: const Color(0xFF4ADE80),
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: Color(0xFF4ADE80),
                                  size: 56,
                                ),
                              )
                            : Container(
                                key: const ValueKey('loading'),
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF60A5FA)
                                      .withOpacity(0.1),
                                  border: Border.all(
                                    color: const Color(0xFF60A5FA)
                                        .withOpacity(0.3),
                                    width: 2,
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(28),
                                  child: CircularProgressIndicator(
                                    color: Color(0xFF60A5FA),
                                    strokeWidth: 2.5,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 28),

                      Text(
                        isSuccess
                            ? 'Scan Successful!'
                            : 'Processing your ID…',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Progress bar while processing
                      if (!isSuccess) ...[
                        const SizedBox(height: 12),
                        SizedBox(
                          width: 220,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: controller.scanProgress.value,
                              backgroundColor: Colors.white12,
                              color: const Color(0xFF60A5FA),
                              minHeight: 6,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${(controller.scanProgress.value * 100).toInt()}%',
                          style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 13,
                          ),
                        ),
                      ],

                      // Extracted ID data cards
                      if (isSuccess &&
                          controller.scannedId.value != null) ...[
                        const SizedBox(height: 20),
                        _IdCard(id: controller.scannedId.value!),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            // Action buttons
            if (isSuccess)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: controller.proceedToProfileForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Continue to Profile',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward_rounded),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: controller.retry,
                      child: const Text(
                        'Scan again',
                        style: TextStyle(color: Colors.white38),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildErrorScreen(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF87171).withOpacity(0.12),
                border: Border.all(
                  color: const Color(0xFFF87171).withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: Color(0xFFF87171),
                size: 54,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Scan Failed',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => Text(
                controller.errorMessage.value,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white54, fontSize: 14),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: controller.retry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text(
                  'Try Again',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: controller.pickFromGallery,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white60,
                side: const BorderSide(color: Colors.white24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12),
              ),
              icon: const Icon(Icons.photo_library_outlined),
              label: const Text('Upload from gallery instead'),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Extracted ID info card ──────────────────────────────────────────────────
class _IdCard extends StatelessWidget {
  final KhmerIdModel id;

  const _IdCard({required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.verified_rounded,
                  color: Color(0xFF4ADE80), size: 18),
              SizedBox(width: 6),
              Text(
                'Extracted Information',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _Row(label: 'ID Number', value: id.idNumber ?? '—'),
          _Row(
            label: 'Full Name',
            value: [id.firstNameEn, id.lastNameEn]
                    .whereType<String>()
                    .join(' ')
                    .trim()
                    .isEmpty
                ? '—'
                : '${id.firstNameEn ?? ''} ${id.lastNameEn ?? ''}'.trim(),
          ),
          if (id.dateOfBirth != null)
            _Row(label: 'Date of Birth', value: id.dateOfBirth!),
          if (id.gender != null)
            _Row(label: 'Gender', value: id.gender!),
          if (id.expiryDate != null)
            _Row(label: 'Expiry', value: id.expiryDate!),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;

  const _Row({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white38, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}