import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

// ─────────────────────────────────────────────
// Enums
// ─────────────────────────────────────────────
enum FormStep { personal, professional, documents }

enum SubmitState { idle, submitting, success, error }

// ─────────────────────────────────────────────
// Controller
// ─────────────────────────────────────────────
class DCompleteFormController extends GetxController {
  // ── Step state ──────────────────────────────
  final currentStep = FormStep.personal.obs;
  final submitState = SubmitState.idle.obs;

  int get stepIndex => FormStep.values.indexOf(currentStep.value);

  // ── Personal step ────────────────────────────
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl  = TextEditingController();
  final phoneCtrl     = TextEditingController();
  final emailCtrl     = TextEditingController();

  final profilePhoto    = Rxn<File>();
  final selectedGender  = ''.obs;
  final genders         = ['Male', 'Female'];

  // ── Professional step ────────────────────────
  final hospitalCtrl   = TextEditingController();
  final educationCtrl  = TextEditingController();
  final backgroundCtrl = TextEditingController();

  final selectedSpecialty = ''.obs;
  final experienceYears   = 0.obs;
  final specialties = [
    'Cardiology', 'Neurology', 'Pediatrics', 'Dentistry',
    'Dermatology', 'Surgery', 'Psychiatry', 'Orthopedics',
    'Gynecology', 'Oncology',
  ];

  // ── Documents step ───────────────────────────
  final uploadedDocs = <File>[].obs;

  // ── Attempt flags (show errors only after user tried to proceed) ──
  final _personalAttempted     = false.obs;
  final _professionalAttempted = false.obs;
  final _documentsAttempted    = false.obs;

  // ─────────────────────────────────────────────
  // Lifecycle
  // ─────────────────────────────────────────────
  @override
  void onClose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    hospitalCtrl.dispose();
    educationCtrl.dispose();
    backgroundCtrl.dispose();
    super.onClose();
  }

  // ─────────────────────────────────────────────
  // Navigation
  // ─────────────────────────────────────────────
  void nextStep() {
    switch (currentStep.value) {
      case FormStep.personal:
        _personalAttempted.value = true;
        if (!_validatePersonal()) return;
        currentStep.value = FormStep.professional;
        break;
      case FormStep.professional:
        _professionalAttempted.value = true;
        if (!_validateProfessional()) return;
        currentStep.value = FormStep.documents;
        break;
      case FormStep.documents:
        break;
    }
  }

  void prevStep() {
    switch (currentStep.value) {
      case FormStep.professional:
        currentStep.value = FormStep.personal;
        break;
      case FormStep.documents:
        currentStep.value = FormStep.professional;
        break;
      case FormStep.personal:
        Get.back();
        break;
    }
  }

  // ─────────────────────────────────────────────
  // Validation — Personal
  // ─────────────────────────────────────────────
  bool _validatePersonal() {
    final errors = <String>[];

    final first = _sanitize(firstNameCtrl.text);
    final last  = _sanitize(lastNameCtrl.text);
    final phone = _sanitize(phoneCtrl.text);
    final email = _sanitize(emailCtrl.text);

    if (first.isEmpty) errors.add('First name is required.');
    else if (first.length < 2) errors.add('First name must be at least 2 characters.');
    else if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(first)) errors.add('First name contains invalid characters.');

    if (last.isEmpty) errors.add('Last name is required.');
    else if (last.length < 2) errors.add('Last name must be at least 2 characters.');
    else if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(last)) errors.add('Last name contains invalid characters.');

    if (selectedGender.value.isEmpty) errors.add('Please select your gender.');

    if (phone.isEmpty) errors.add('Phone number is required.');
    else if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(phone.replaceAll(' ', '')))
      errors.add('Enter a valid phone number (7–15 digits).');

    if (email.isEmpty) errors.add('Email address is required.');
    else if (!RegExp(r'^[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}$').hasMatch(email))
      errors.add('Enter a valid email address.');

    if (errors.isNotEmpty) {
      _showValidationSnackbar(errors.first);
      return false;
    }
    return true;
  }

  // ─────────────────────────────────────────────
  // Validation — Professional
  // ─────────────────────────────────────────────
  bool _validateProfessional() {
    final errors = <String>[];

    if (selectedSpecialty.value.isEmpty) errors.add('Please select your specialty.');

    final hospital = _sanitize(hospitalCtrl.text);
    if (hospital.isEmpty) errors.add('Hospital or clinic name is required.');
    else if (hospital.length < 3) errors.add('Hospital name must be at least 3 characters.');

    if (experienceYears.value < 0) errors.add('Experience years cannot be negative.');

    final background = _sanitize(backgroundCtrl.text);
    if (background.isEmpty) errors.add('Professional background is required.');
    else if (background.length < 30)
      errors.add('Please describe your background in at least 30 characters.');
    else if (background.length > 1000)
      errors.add('Background description must be under 1000 characters.');

    if (errors.isNotEmpty) {
      _showValidationSnackbar(errors.first);
      return false;
    }
    return true;
  }

  // ─────────────────────────────────────────────
  // Validation — Documents
  // ─────────────────────────────────────────────
  bool _validateDocuments() {
    if (uploadedDocs.isEmpty) {
      _showValidationSnackbar('Please upload at least one document.');
      return false;
    }
    return true;
  }

  // ─────────────────────────────────────────────
  // Setters
  // ─────────────────────────────────────────────
  void setGender(String g) => selectedGender.value = g;

  void setSpecialty(String s) => selectedSpecialty.value = s;

  void incrementExp() {
    if (experienceYears.value < 60) experienceYears.value++;
  }

  void decrementExp() {
    if (experienceYears.value > 0) experienceYears.value--;
  }

  // ─────────────────────────────────────────────
  // Profile Photo
  // ─────────────────────────────────────────────
  Future<void> pickProfilePhoto() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (picked == null) return;

      final file = File(picked.path);
      final bytes = await file.length();

      // Max 5 MB
      if (bytes > 5 * 1024 * 1024) {
        _showErrorSnackbar('Photo too large', 'Profile photo must be under 5 MB.');
        return;
      }

      final ext = picked.path.split('.').last.toLowerCase();
      if (!['jpg', 'jpeg', 'png'].contains(ext)) {
        _showErrorSnackbar('Invalid format', 'Only JPG and PNG photos are allowed.');
        return;
      }

      profilePhoto.value = file;
    } catch (_) {
      _showErrorSnackbar('Error', 'Could not pick photo. Please try again.');
    }
  }

  // ─────────────────────────────────────────────
  // Documents
  // ─────────────────────────────────────────────
  Future<void> pickDocuments() async {
    if (uploadedDocs.length >= 5) {
      _showErrorSnackbar('Limit reached', 'You can upload a maximum of 5 documents.');
      return;
    }

    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );
      if (result == null || result.files.isEmpty) return;

      final remaining = 5 - uploadedDocs.length;
      final selected  = result.files.take(remaining).toList();

      for (final f in selected) {
        if (f.path == null) continue;

        final file  = File(f.path!);
        final bytes = await file.length();

        // Max 10 MB per file
        if (bytes > 10 * 1024 * 1024) {
          _showErrorSnackbar('File too large', '"${f.name}" exceeds 10 MB.');
          continue;
        }

        final ext = f.extension?.toLowerCase() ?? '';
        if (!['pdf', 'jpg', 'jpeg', 'png'].contains(ext)) {
          _showErrorSnackbar('Invalid format', '"${f.name}" is not a supported format.');
          continue;
        }

        // Prevent duplicates by name
        final alreadyAdded = uploadedDocs.any(
          (d) => d.path.split('/').last == f.name,
        );
        if (alreadyAdded) {
          _showErrorSnackbar('Duplicate', '"${f.name}" has already been added.');
          continue;
        }

        uploadedDocs.add(file);
      }

      if (result.files.length > remaining) {
        Get.snackbar(
          'Some files skipped',
          'Only $remaining more file(s) could be added (5-file limit).',
          backgroundColor: Colors.orange.shade50,
          colorText: Colors.orange.shade800,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (_) {
      _showErrorSnackbar('Error', 'Could not pick files. Please try again.');
    }
  }

  void removeDoc(int index) {
    if (index < 0 || index >= uploadedDocs.length) return;
    uploadedDocs.removeAt(index);
  }

  String docName(File file) {
    final name = file.path.split('/').last;
    return name.length > 28 ? '${name.substring(0, 25)}...' : name;
  }

  // ─────────────────────────────────────────────
  // Submit
  // ─────────────────────────────────────────────
  Future<void> submit() async {
    _documentsAttempted.value = true;
    if (!_validateDocuments()) return;

    // Double-check all steps before submitting
    if (!_validatePersonal() || !_validateProfessional()) {
      _showErrorSnackbar(
        'Incomplete form',
        'Some required fields are missing. Please review all steps.',
      );
      currentStep.value = FormStep.personal;
      return;
    }

    submitState.value = SubmitState.submitting;

    try {
      // Sanitize all text fields before sending
      final payload = {
        'firstName'    : _sanitize(firstNameCtrl.text),
        'lastName'     : _sanitize(lastNameCtrl.text),
        'gender'       : selectedGender.value,
        'phone'        : _sanitize(phoneCtrl.text),
        'email'        : _sanitize(emailCtrl.text).toLowerCase(),
        'specialty'    : selectedSpecialty.value,
        'hospital'     : _sanitize(hospitalCtrl.text),
        'experience'   : experienceYears.value,
        'education'    : _sanitize(educationCtrl.text),
        'background'   : _sanitize(backgroundCtrl.text),
        'profilePhoto' : profilePhoto.value?.path,
        'documents'    : uploadedDocs.map((f) => f.path).toList(),
      };

      // TODO: replace with your actual API call
      // e.g. await _apiService.registerDoctor(payload);
      await Future.delayed(const Duration(seconds: 2)); // mock network

      submitState.value = SubmitState.success;
    } catch (e) {
      submitState.value = SubmitState.error;
      _showErrorSnackbar(
        'Submission failed',
        'Something went wrong. Please check your connection and try again.',
      );
    }
  }

  // ─────────────────────────────────────────────
  // Helpers — Sanitization
  // ─────────────────────────────────────────────

  /// Trims whitespace and collapses internal multiple spaces.
  String _sanitize(String input) =>
      input.trim().replaceAll(RegExp(r'\s+'), ' ');

  // ─────────────────────────────────────────────
  // Helpers — Snackbars
  // ─────────────────────────────────────────────
  void _showValidationSnackbar(String message) {
    Get.snackbar(
      'Please check your input',
      message,
      backgroundColor: const Color(0xFFFEF2F2),
      colorText: const Color(0xFFDC2626),
      icon: const Icon(Icons.error_outline_rounded, color: Color(0xFFDC2626)),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      duration: const Duration(seconds: 3),
    );
  }

  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: const Color(0xFFFEF2F2),
      colorText: const Color(0xFFDC2626),
      icon: const Icon(Icons.warning_amber_rounded, color: Color(0xFFDC2626)),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      duration: const Duration(seconds: 3),
    );
  }

  // ─────────────────────────────────────────────
  // Expose attempt flags (for view to show inline errors)
  // ─────────────────────────────────────────────
  bool get personalAttempted     => _personalAttempted.value;
  bool get professionalAttempted => _professionalAttempted.value;
  bool get documentsAttempted    => _documentsAttempted.value;

  // Inline field-level validators used by the view's TextFormField
  String? validateFirstName(String? v) {
    if (!personalAttempted) return null;
    final s = _sanitize(v ?? '');
    if (s.isEmpty) return 'Required';
    if (s.length < 2) return 'At least 2 characters';
    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(s)) return 'Letters only';
    return null;
  }

  String? validateLastName(String? v) {
    if (!personalAttempted) return null;
    final s = _sanitize(v ?? '');
    if (s.isEmpty) return 'Required';
    if (s.length < 2) return 'At least 2 characters';
    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(s)) return 'Letters only';
    return null;
  }

  String? validatePhone(String? v) {
    if (!personalAttempted) return null;
    final s = _sanitize(v ?? '').replaceAll(' ', '');
    if (s.isEmpty) return 'Required';
    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(s)) return 'Invalid phone';
    return null;
  }

  String? validateEmail(String? v) {
    if (!personalAttempted) return null;
    final s = _sanitize(v ?? '');
    if (s.isEmpty) return 'Required';
    if (!RegExp(r'^[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}$').hasMatch(s))
      return 'Invalid email';
    return null;
  }

  String? validateHospital(String? v) {
    if (!professionalAttempted) return null;
    final s = _sanitize(v ?? '');
    if (s.isEmpty) return 'Required';
    if (s.length < 3) return 'At least 3 characters';
    return null;
  }

  String? validateBackground(String? v) {
    if (!professionalAttempted) return null;
    final s = _sanitize(v ?? '');
    if (s.isEmpty) return 'Required';
    if (s.length < 30) return 'At least 30 characters (${s.length}/30)';
    if (s.length > 1000) return 'Too long (max 1000 characters)';
    return null;
  }
}