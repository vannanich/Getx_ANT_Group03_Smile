// lib/controllers/d_complete_form_controller.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum FormStep { personal, professional, documents }
enum SubmitState { idle, submitting, success, error }

class DCompleteFormController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // ── Step tracker ──────────────────────────────────────────────────────────
  final Rx<FormStep> currentStep = FormStep.personal.obs;
  final Rx<SubmitState> submitState = SubmitState.idle.obs;

  // ── Pre-filled from scanned ID ────────────────────────────────────────────
  late final String scannedIdNumber;
  late final String scannedFirstName;
  late final String scannedLastName;

  // ── Step 1: Personal ─────────────────────────────────────────────────────
  late final TextEditingController firstNameCtrl;
  late final TextEditingController lastNameCtrl;
  late final TextEditingController phoneCtrl;
  late final TextEditingController emailCtrl;
  final Rx<File?> profilePhoto = Rx(null);
  final RxString selectedGender = ''.obs;

  // ── Step 2: Professional ──────────────────────────────────────────────────
  late final TextEditingController specialtyCtrl;
  late final TextEditingController hospitalCtrl;
  late final TextEditingController experienceCtrl;
  late final TextEditingController backgroundCtrl;
  late final TextEditingController educationCtrl;
  final RxInt experienceYears = 0.obs;
  final RxString selectedSpecialty = ''.obs;

  // ── Step 3: Documents ─────────────────────────────────────────────────────
  final RxList<File> uploadedDocs = <File>[].obs;

  // ── Options ───────────────────────────────────────────────────────────────
  final List<String> genders = ['Male', 'Female'];
  final List<String> specialties = [
    'General Practitioner',
    'Cardiologist',
    'Neurologist',
    'Pediatrician',
    'Psychiatrist / Mental Health',
    'Dermatologist',
    'Orthopedic',
    'Gynecologist',
    'Oncologist',
    'Radiologist',
    'Anesthesiologist',
    'Other',
  ];

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    // Get scanned ID data from previous screen
    final args = Get.arguments;
    scannedIdNumber = args?.idNumber ?? '';
    scannedFirstName = args?.firstNameEn ?? '';
    scannedLastName = args?.lastNameEn ?? '';

    firstNameCtrl = TextEditingController(text: scannedFirstName);
    lastNameCtrl = TextEditingController(text: scannedLastName);
    phoneCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    specialtyCtrl = TextEditingController();
    hospitalCtrl = TextEditingController();
    experienceCtrl = TextEditingController();
    backgroundCtrl = TextEditingController();
    educationCtrl = TextEditingController();
  }

  @override
  void onClose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    specialtyCtrl.dispose();
    hospitalCtrl.dispose();
    experienceCtrl.dispose();
    backgroundCtrl.dispose();
    educationCtrl.dispose();
    super.onClose();
  }

  // ── Step navigation ───────────────────────────────────────────────────────
  void nextStep() {
    if (currentStep.value == FormStep.personal) {
      currentStep.value = FormStep.professional;
    } else if (currentStep.value == FormStep.professional) {
      currentStep.value = FormStep.documents;
    }
  }

  void prevStep() {
    if (currentStep.value == FormStep.professional) {
      currentStep.value = FormStep.personal;
    } else if (currentStep.value == FormStep.documents) {
      currentStep.value = FormStep.professional;
    }
  }

  int get stepIndex {
    switch (currentStep.value) {
      case FormStep.personal: return 0;
      case FormStep.professional: return 1;
      case FormStep.documents: return 2;
    }
  }

  // ── Profile photo ─────────────────────────────────────────────────────────
  Future<void> pickProfilePhoto() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image != null) profilePhoto.value = File(image.path);
  }

  // ── Gender ────────────────────────────────────────────────────────────────
  void setGender(String value) => selectedGender.value = value;

  // ── Specialty ─────────────────────────────────────────────────────────────
  void setSpecialty(String value) {
    selectedSpecialty.value = value;
    specialtyCtrl.text = value;
  }

  // ── Experience stepper ────────────────────────────────────────────────────
  void incrementExp() {
    if (experienceYears.value < 50) {
      experienceYears.value++;
      experienceCtrl.text = experienceYears.value.toString();
    }
  }

  void decrementExp() {
    if (experienceYears.value > 0) {
      experienceYears.value--;
      experienceCtrl.text = experienceYears.value.toString();
    }
  }

 Future<void> pickDocuments() async {
  final List<XFile> images = await _picker.pickMultiImage(
    imageQuality: 100,
  );

  if (images.isNotEmpty) {
    final newFiles = images.map((x) => File(x.path)).toList();

    if (uploadedDocs.length + newFiles.length > 5) {
      Get.snackbar(
        'Limit Reached',
        'Maximum 5 documents allowed.',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    uploadedDocs.addAll(newFiles);
  }
}

  void removeDoc(int index) => uploadedDocs.removeAt(index);

  String docIcon(String path) {
    if (path.endsWith('.pdf')) return '📄';
    return '🖼️';
  }

  String docName(File file) {
    final name = file.path.split('/').last.split('\\').last;
    return name.length > 28 ? '${name.substring(0, 25)}...' : name;
  }

  // ── Submit ────────────────────────────────────────────────────────────────
  Future<void> submit() async {
    if (uploadedDocs.isEmpty) {
      Get.snackbar(
        'Documents Required',
        'Please upload at least one graduation or medical certificate.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFFEE2E2),
        colorText: const Color(0xFF991B1B),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    submitState.value = SubmitState.submitting;
    await Future.delayed(const Duration(seconds: 2)); // Replace with real API
    submitState.value = SubmitState.success;
  }
}