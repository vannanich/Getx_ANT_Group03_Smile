// lib/views/d_complete_form_view.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/d_complete_form/d_complete_form_controller.dart';

class DCompleteFormView extends GetView<DCompleteFormController> {
  const DCompleteFormView({super.key});

  // ── Brand colors ──────────────────────────────────────────────────────────
  static const _primary = Color(0xFF2563EB);
  static const _primaryLight = Color(0xFFEFF6FF);
  static const _surface = Color(0xFFF8FAFC);
  static const _border = Color(0xFFE2E8F0);
  static const _textDark = Color(0xFF0F172A);
  static const _textMid = Color(0xFF475569);
  static const _textLight = Color(0xFF94A3B8);
  static const _success = Color(0xFF10B981);
  static const _successLight = Color(0xFFECFDF5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _surface,
      body: Obx(() {
        if (controller.submitState.value == SubmitState.success) {
          return _buildSuccessScreen();
        }
        return _buildFormScreen(context);
      }),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // Form screen
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildFormScreen(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildStepIndicator(),
        Expanded(
          child: Obx(() {
            switch (controller.currentStep.value) {
              case FormStep.personal:
                return _buildPersonalStep(context);
              case FormStep.professional:
                return _buildProfessionalStep(context);
              case FormStep.documents:
                return _buildDocumentsStep(context);
            }
          }),
        ),
        _buildBottomBar(),
      ],
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: _border)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 16, 16),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    size: 18, color: _textDark),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Doctor Registration',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: _textDark,
                        letterSpacing: -0.3,
                      ),
                    ),
                    Obx(() => Text(
                          _stepSubtitle(),
                          style: const TextStyle(
                              fontSize: 13, color: _textMid),
                        )),
                  ],
                ),
              ),
              // ID badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: _primary.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.verified_rounded,
                        size: 13, color: _primary),
                    const SizedBox(width: 4),
                    Text(
                      'ID Verified',
                      style: TextStyle(
                        fontSize: 11,
                        color: _primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _stepSubtitle() {
    switch (controller.currentStep.value) {
      case FormStep.personal: return 'Step 1 of 3 · Personal Info';
      case FormStep.professional: return 'Step 2 of 3 · Professional Info';
      case FormStep.documents: return 'Step 3 of 3 · Upload Documents';
    }
  }

  // ── Step indicator ────────────────────────────────────────────────────────
  Widget _buildStepIndicator() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Obx(() {
        final step = controller.stepIndex;
        return Row(
          children: List.generate(3, (i) {
            final isActive = i == step;
            final isDone = i < step;
            return Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: isDone
                            ? _success
                            : isActive
                                ? _primary
                                : _border,
                      ),
                    ),
                  ),
                  if (i < 2) const SizedBox(width: 6),
                ],
              ),
            );
          }),
        );
      }),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // Step 1 — Personal Info
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildPersonalStep(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile photo
          Center(child: _buildProfilePhotoWidget()),
          const SizedBox(height: 28),

          _sectionLabel('Full Name'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: controller.firstNameCtrl,
                  label: 'First Name',
                  icon: Icons.person_outline_rounded,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Required' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTextField(
                  controller: controller.lastNameCtrl,
                  label: 'Last Name',
                  icon: Icons.person_outline_rounded,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Required' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          _sectionLabel('Gender'),
          const SizedBox(height: 12),
          _buildGenderSelector(),
          const SizedBox(height: 20),

          _sectionLabel('Contact'),
          const SizedBox(height: 12),
          _buildTextField(
            controller: controller.phoneCtrl,
            label: 'Phone Number',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: controller.emailCtrl,
            label: 'Email Address',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Required';
              if (!v.contains('@')) return 'Invalid email';
              return null;
            },
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildProfilePhotoWidget() {
    return GestureDetector(
      onTap: controller.pickProfilePhoto,
      child: Obx(() {
        final photo = controller.profilePhoto.value;
        return Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _primaryLight,
                border: Border.all(color: _primary.withOpacity(0.3), width: 2),
                image: photo != null
                    ? DecorationImage(
                        image: FileImage(photo),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: photo == null
                  ? const Icon(Icons.person_rounded,
                      size: 48, color: _primary)
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: _primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.camera_alt_rounded,
                    size: 15, color: Colors.white),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildGenderSelector() {
    return Obx(() => Row(
          children: controller.genders.map((g) {
            final selected = controller.selectedGender.value == g;
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.setGender(g),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(
                      right: g == controller.genders.last ? 0 : 12),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: selected ? _primary : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected ? _primary : _border,
                      width: selected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        g == 'Male'
                            ? Icons.male_rounded
                            : Icons.female_rounded,
                        color: selected ? Colors.white : _textMid,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        g,
                        style: TextStyle(
                          color: selected ? Colors.white : _textMid,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ));
  }

  // ══════════════════════════════════════════════════════════════════════════
  // Step 2 — Professional Info
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildProfessionalStep(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('Specialty'),
          const SizedBox(height: 12),
          _buildSpecialtyGrid(),
          const SizedBox(height: 20),

          _sectionLabel('Hospital / Clinic'),
          const SizedBox(height: 12),
          _buildTextField(
            controller: controller.hospitalCtrl,
            label: 'Hospital or Clinic Name',
            icon: Icons.local_hospital_outlined,
            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 20),

          _sectionLabel('Years of Experience'),
          const SizedBox(height: 12),
          _buildExperienceStepper(),
          const SizedBox(height: 20),

          _sectionLabel('Education'),
          const SizedBox(height: 12),
          _buildTextField(
            controller: controller.educationCtrl,
            label: 'e.g. MD from University of Health Sciences',
            icon: Icons.school_outlined,
            maxLines: 2,
          ),
          const SizedBox(height: 20),

          _sectionLabel('Professional Background'),
          const SizedBox(height: 12),
          _buildTextField(
            controller: controller.backgroundCtrl,
            label: 'Briefly describe your medical background...',
            icon: Icons.notes_rounded,
            maxLines: 4,
            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildSpecialtyGrid() {
    return Obx(() => Wrap(
          spacing: 8,
          runSpacing: 8,
          children: controller.specialties.map((s) {
            final selected = controller.selectedSpecialty.value == s;
            return GestureDetector(
              onTap: () => controller.setSpecialty(s),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? _primary : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selected ? _primary : _border,
                  ),
                ),
                child: Text(
                  s,
                  style: TextStyle(
                    fontSize: 13,
                    color: selected ? Colors.white : _textMid,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ));
  }

  Widget _buildExperienceStepper() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          const Icon(Icons.work_history_outlined,
              color: _textLight, size: 20),
          const SizedBox(width: 12),
          const Expanded(
            child: Text('Years of experience',
                style: TextStyle(color: _textMid, fontSize: 14)),
          ),
          // Decrement
          GestureDetector(
            onTap: controller.decrementExp,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _border),
              ),
              child: const Icon(Icons.remove_rounded,
                  size: 18, color: _textMid),
            ),
          ),
          const SizedBox(width: 16),
          Obx(() => Text(
                '${controller.experienceYears.value}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: _primary,
                ),
              )),
          const SizedBox(width: 16),
          // Increment
          GestureDetector(
            onTap: controller.incrementExp,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.add_rounded,
                  size: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // Step 3 — Documents
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildDocumentsStep(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _primaryLight,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _primary.withOpacity(0.15)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline_rounded,
                    color: _primary, size: 20),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Required Documents',
                        style: TextStyle(
                          color: _primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Please upload your medical degree, license, or any graduation certificate. Max 5 files (PDF, JPG, PNG).',
                        style: TextStyle(color: _textMid, fontSize: 12, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          _sectionLabel('Upload Documents'),
          const SizedBox(height: 12),

          // Upload button
          GestureDetector(
            onTap: controller.pickDocuments,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _primary.withOpacity(0.4),
                  width: 1.5,
                  // dashed via CustomPaint or just solid
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: _primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.cloud_upload_outlined,
                        color: _primary, size: 28),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Tap to upload files',
                    style: TextStyle(
                      color: _primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'PDF, JPG, PNG · Max 5 files',
                    style: TextStyle(color: _textLight, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Uploaded files list
          Obx(() {
            if (controller.uploadedDocs.isEmpty) {
              return const SizedBox();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _sectionLabel('Uploaded'),
                    const SizedBox(width: 8),
                    Obx(() => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _successLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${controller.uploadedDocs.length}/5',
                            style: const TextStyle(
                              color: _success,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 12),
                ...controller.uploadedDocs.asMap().entries.map(
                      (e) => _buildDocTile(e.key, e.value),
                    ),
              ],
            );
          }),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildDocTile(int index, File file) {
    final isPdf = file.path.endsWith('.pdf');
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isPdf
                  ? const Color(0xFFFEE2E2)
                  : const Color(0xFFE0F2FE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isPdf
                  ? Icons.picture_as_pdf_rounded
                  : Icons.image_rounded,
              color: isPdf
                  ? const Color(0xFFDC2626)
                  : const Color(0xFF0284C7),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.docName(file),
                  style: const TextStyle(
                    color: _textDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isPdf ? 'PDF Document' : 'Image File',
                  style: const TextStyle(color: _textLight, fontSize: 11),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => controller.removeDoc(index),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.close_rounded,
                  size: 16, color: Color(0xFFDC2626)),
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // Bottom bar
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(top: BorderSide(color: _border)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Obx(() {
            final isLast =
                controller.currentStep.value == FormStep.documents;
            final isFirst =
                controller.currentStep.value == FormStep.personal;
            final isSubmitting =
                controller.submitState.value == SubmitState.submitting;

            return Row(
              children: [
                // Back button
                if (!isFirst) ...[
                  GestureDetector(
                    onTap: controller.prevStep,
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: _surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _border),
                      ),
                      child: const Icon(Icons.arrow_back_rounded,
                          color: _textMid),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],

                // Next / Submit button
                Expanded(
                  child: GestureDetector(
                    onTap: isSubmitting
                        ? null
                        : isLast
                            ? controller.submit
                            : controller.nextStep,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 52,
                      decoration: BoxDecoration(
                        color: _primary,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: isSubmitting
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Text(
                                    isLast ? 'Submit Registration' : 'Continue',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    isLast
                                        ? Icons.check_circle_outline_rounded
                                        : Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // Success screen
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildSuccessScreen() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            // Success animation container
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _successLight,
                border: Border.all(color: _success.withOpacity(0.3), width: 2),
              ),
              child: const Icon(Icons.check_circle_rounded,
                  color: _success, size: 72),
            ),
            const SizedBox(height: 32),
            const Text(
              'Registration Submitted!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: _textDark,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Your profile is under review.\nOur team will verify your documents\nand activate your account within 24–48 hours.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: _textMid,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            // Info card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _border),
              ),
              child: Column(
                children: [
                  _successInfoRow(
                    Icons.access_time_rounded,
                    'Review Time',
                    '24–48 hours',
                  ),
                  const Divider(height: 24, color: _border),
                  _successInfoRow(
                    Icons.notifications_outlined,
                    'Notification',
                    'Email & App notification',
                  ),
                  const Divider(height: 24, color: _border),
                  _successInfoRow(
                    Icons.shield_outlined,
                    'Status',
                    'Pending Verification',
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () => Get.offAllNamed('/home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Back to Home',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _successInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _primaryLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: _primary, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label,
              style: const TextStyle(color: _textMid, fontSize: 13)),
        ),
        Text(
          value,
          style: const TextStyle(
            color: _textDark,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // Shared helpers
  // ══════════════════════════════════════════════════════════════════════════
  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: _textMid,
        letterSpacing: 0.4,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(
        fontSize: 14,
        color: _textDark,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: _textLight, fontSize: 14),
        prefixIcon: Icon(icon, color: _textLight, size: 20),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              const BorderSide(color: Color(0xFFEF4444)),
        ),
      ),
    );
  }
}