import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:flutter_application_1/app/shared/themes/app_colors.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/doctor/d_complete_form/d_complete_form_controller.dart';

class DCompleteFormView extends GetView<DCompleteFormController> {
  DCompleteFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary, // light purple bg
      body: Obx(() {
        if (controller.submitState.value == SubmitState.success) {
          return _buildSuccessScreen();
        }
        return _buildFormScreen(context);
      }),
    );
  }

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

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary, // light purple bg
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 16, 16),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios_new_rounded,
                    size: 18, color: AppColors.textDark),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Doctor Registration',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                        letterSpacing: -0.3,
                      ),
                    ),
                    Obx(() => Text(
                          _stepSubtitle(),
                          style: TextStyle(
                              fontSize: 13, color: AppColors.textMid),
                        )),
                  ],
                ),
              ),
              // ID badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.1), // subtle secondary tint
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.secondary),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified_rounded,
                        size: 13, color: Colors.green),
                    SizedBox(width: 4),
                    Text(
                      'ID Verified',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.secondary, // dark purple text
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
      case FormStep.personal:
        return 'Step 1 of 3 · Personal Info';
      case FormStep.professional:
        return 'Step 2 of 3 · Professional Info';
      case FormStep.documents:
        return 'Step 3 of 3 · Upload Documents';
    }
  }

  Widget _buildStepIndicator() {
    return Container(
      color: AppColors.primary, // light purple bg
      padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
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
                      duration: Duration(milliseconds: 300),
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: isDone
                            ? AppColors.secondary   // completed = dark purple
                            : isActive
                                ? AppColors.secondary.withOpacity(0.5) // active = medium purple
                                : AppColors.border, // inactive = grey
                      ),
                    ),
                  ),
                  if (i < 2) SizedBox(width: 6),
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
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: _buildProfilePhotoWidget()),
          SizedBox(height: 28),
          _sectionLabel('Full Name'),
          SizedBox(height: 12),
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
              SizedBox(width: 12),
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
          SizedBox(height: 20),
          _sectionLabel('Gender'),
          SizedBox(height: 12),
          _buildGenderSelector(),
          SizedBox(height: 20),
          _sectionLabel('Contact'),
          SizedBox(height: 12),
          _buildTextField(
            controller: controller.phoneCtrl,
            label: 'Phone Number',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
          ),
          SizedBox(height: 12),
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
          SizedBox(height: 100),
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
                color: AppColors.primary, // light purple bg
                border: Border.all(color: AppColors.secondary, width: 2), // dark purple border
                image: photo != null
                    ? DecorationImage(
                        image: FileImage(photo),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: photo == null
                  ? Icon(Icons.person_rounded,
                      size: 48, color: AppColors.secondary) // dark purple icon
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.secondary, // dark purple
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(Icons.camera_alt_rounded,
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
                  duration: Duration(milliseconds: 200),
                  margin: EdgeInsets.only(
                      right: g == controller.genders.last ? 0 : 12),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.secondary : Colors.white, // selected = dark purple
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected ? AppColors.secondary : AppColors.border,
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
                        color: selected ? Colors.white : AppColors.textMid,
                        size: 20,
                      ),
                      SizedBox(width: 6),
                      Text(
                        g,
                        style: TextStyle(
                          color: selected ? Colors.white : AppColors.textMid,
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
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('Specialty'),
          SizedBox(height: 12),
          _buildSpecialtyGrid(),
          SizedBox(height: 20),
          _sectionLabel('Hospital / Clinic'),
          SizedBox(height: 12),
          _buildTextField(
            controller: controller.hospitalCtrl,
            label: 'Hospital or Clinic Name',
            icon: Icons.local_hospital_outlined,
            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
          ),
          SizedBox(height: 20),
          _sectionLabel('Years of Experience'),
          SizedBox(height: 12),
          _buildExperienceStepper(),
          SizedBox(height: 20),
          _sectionLabel('Education'),
          SizedBox(height: 12),
          _buildTextField(
            controller: controller.educationCtrl,
            label: 'e.g. MD from University of Health Sciences',
            icon: Icons.school_outlined,
            maxLines: 2,
          ),
          SizedBox(height: 20),
          _sectionLabel('Professional Background'),
          SizedBox(height: 12),
          _buildTextField(
            controller: controller.backgroundCtrl,
            label: 'Briefly describe your medical background...',
            icon: Icons.notes_rounded,
            maxLines: 4,
            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
          ),
          SizedBox(height: 100),
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
                duration: Duration(milliseconds: 180),
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? AppColors.secondary : Colors.white, // selected = dark purple
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selected ? AppColors.secondary : AppColors.border,
                  ),
                ),
                child: Text(
                  s,
                  style: TextStyle(
                    fontSize: 13,
                    color: selected ? Colors.white : AppColors.textMid,
                    fontWeight:
                        selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ));
  }

  Widget _buildExperienceStepper() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(Icons.work_history_outlined,
              color: AppColors.secondary, size: 20), // dark purple icon
          SizedBox(width: 12),
          Expanded(
            child: Text('Years of experience',
                style: TextStyle(color: AppColors.textMid, fontSize: 14)),
          ),
          // Decrement
          GestureDetector(
            onTap: controller.decrementExp,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primary, // light purple bg
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.secondary),
              ),
              child: Icon(Icons.remove_rounded,
                  size: 18, color: AppColors.secondary), // dark purple icon
            ),
          ),
          SizedBox(width: 16),
          Obx(() => Text(
                '${controller.experienceYears.value}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondary, // dark purple
                ),
              )),
          SizedBox(width: 16),
          // Increment
          GestureDetector(
            onTap: controller.incrementExp,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.secondary, // dark purple bg
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.add_rounded,
                  size: 18, color: Colors.white), // white icon on dark
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsStep(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info banner
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.secondary, // dark purple banner
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.secondary.withOpacity(0.15)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline_rounded, color: Colors.white),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Required Documents',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Please upload your medical degree, license, or any graduation certificate. Max 5 files (PDF, JPG, PNG).',
                        style: TextStyle(
                            color: Colors.white, fontSize: 12, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          _sectionLabel('Upload Documents'),
          SizedBox(height: 12),
          // Upload button
          GestureDetector(
            onTap: controller.pickDocuments,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: AppColors.primary, // light purple bg
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.secondary.withOpacity(0.4),
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.secondary, // dark purple circle
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.cloud_upload_outlined,
                        color: Colors.white, size: 28),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Tap to upload files',
                    style: TextStyle(
                      color: AppColors.secondary, // dark purple text
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'PDF, JPG, PNG · Max 5 files',
                    style:
                        TextStyle(color: AppColors.textLight, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          // Uploaded files list
          Obx(() {
            if (controller.uploadedDocs.isEmpty) return SizedBox();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _sectionLabel('Uploaded'),
                    SizedBox(width: 8),
                    Obx(() => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary, // light purple bg
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${controller.uploadedDocs.length}/5',
                            style: TextStyle(
                              color: AppColors.secondary, // dark purple text
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )),
                  ],
                ),
                SizedBox(height: 12),
                ...controller.uploadedDocs.asMap().entries.map(
                      (e) => _buildDocTile(e.key, e.value),
                    ),
              ],
            );
          }),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildDocTile(int index, File file) {
    final isPdf = file.path.endsWith('.pdf');
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isPdf ? Color(0xFFFEE2E2) : Color(0xFFE0F2FE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isPdf ? Icons.picture_as_pdf_rounded : Icons.image_rounded,
              color: isPdf ? Color(0xFFDC2626) : Color(0xFF0284C7),
              size: 22,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.docName(file),
                  style: TextStyle(
                    color: AppColors.textDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  isPdf ? 'PDF Document' : 'Image File',
                  style:
                      TextStyle(color: AppColors.textLight, fontSize: 11),
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
                color: Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.close_rounded,
                  size: 16, color: Color(0xFFDC2626)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Obx(() {
            final isLast =
                controller.currentStep.value == FormStep.documents;
            final isFirst =
                controller.currentStep.value == FormStep.personal;
            final isSubmitting =
                controller.submitState.value == SubmitState.submitting;

            return Row(
              children: [
                if (!isFirst) ...[
                  GestureDetector(
                    onTap: controller.prevStep,
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.primary, // light purple bg
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.secondary),
                      ),
                      child: Icon(Icons.arrow_back_rounded,
                          color: AppColors.secondary), // dark purple icon
                    ),
                  ),
                  SizedBox(width: 12),
                ],
                Expanded(
                  child: GestureDetector(
                    onTap: isSubmitting
                        ? null
                        : isLast
                            ? controller.submit
                            : controller.nextStep,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.secondary, // dark purple button
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: isSubmitting
                            ? SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    isLast
                                        ? 'Submit Registration'
                                        : 'Continue',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 6),
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

  Widget _buildSuccessScreen() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary, // light purple bg
                border: Border.all(color: AppColors.secondary, width: 2),
              ),
              child: Icon(Icons.check_circle_rounded,
                  color: AppColors.secondary, size: 72), // dark purple
            ),
            SizedBox(height: 32),
            Text(
              'Registration Submitted!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Your profile is under review.\nOur team will verify your documents\nand activate your account within 24–48 hours.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.textMid,
                height: 1.6,
              ),
            ),
            SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _successInfoRow(
                      Icons.access_time_rounded, 'Review Time', '24–48 hours'),
                  Divider(height: 24, color: AppColors.border),
                  _successInfoRow(Icons.notifications_outlined, 'Notification',
                      'Email & App notification'),
                  Divider(height: 24, color: AppColors.border),
                  _successInfoRow(Icons.shield_outlined, 'Status',
                      'Pending Verification'),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () => Get.offAllNamed(AppRoutes.dHomescreen),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary, // dark purple button
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Back to Home',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(height: 12),
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
            color: AppColors.primary, // light purple bg
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.secondary, size: 18), // dark purple icon
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(label,
              style: TextStyle(color: AppColors.textMid, fontSize: 13)),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textMid,
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
      style: TextStyle(
        fontSize: 14,
        color: AppColors.textDark,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: AppColors.textLight, fontSize: 14),
        prefixIcon: Icon(icon, color: AppColors.secondary, size: 20), // dark purple icon
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.secondary, width: 1.5), // dark purple focus
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Color(0xFFEF4444)),
        ),
      ),
    );
  }
}