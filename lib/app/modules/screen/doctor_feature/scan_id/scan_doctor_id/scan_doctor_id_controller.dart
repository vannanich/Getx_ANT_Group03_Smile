// lib/controllers/id_scan_controller.dart
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter_application_1/app/models/khmer_id.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

enum ScanState { idle, scanning, processing, success, error }

class ScanDoctorIdController extends GetxController {
  // ── Camera ──────────────────────────────────────────────────────────────
  CameraController? cameraController;
  List<CameraDescription> cameras = [];

  final Rx<ScanState> scanState = ScanState.idle.obs;
  final RxBool isCameraReady = false.obs;
  final RxBool isFlashOn = false.obs;
  final RxDouble scanProgress = 0.0.obs;

  // ── Result ───────────────────────────────────────────────────────────────
  final Rx<KhmerIdModel?> scannedId = Rx(null);
  final RxString errorMessage = ''.obs;

  // ── ML Kit ───────────────────────────────────────────────────────────────
  final TextRecognizer _textRecognizer = TextRecognizer(
    script: TextRecognitionScript.latin,
  );
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _initCamera();
  }

  @override
  void onClose() {
    cameraController?.dispose();
    _textRecognizer.close();
    super.onClose();
  }

  // ── Camera init ──────────────────────────────────────────────────────────
  Future<void> _initCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      errorMessage.value = 'Camera permission is required to scan your ID.';
      return;
    }

    try {
      cameras = await availableCameras();
      if (cameras.isEmpty) {
        errorMessage.value = 'No camera found on this device.';
        return;
      }

      cameraController = CameraController(
        cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.nv21
            : ImageFormatGroup.bgra8888,
      );

      await cameraController!.initialize();
      isCameraReady.value = true;
    } catch (e) {
      errorMessage.value = 'Failed to initialize camera: $e';
    }
  }

  // ── Toggle flash ─────────────────────────────────────────────────────────
  Future<void> toggleFlash() async {
    if (cameraController == null || !isCameraReady.value) return;
    isFlashOn.value = !isFlashOn.value;
    await cameraController!.setFlashMode(
      isFlashOn.value ? FlashMode.torch : FlashMode.off,
    );
  }

  // ── Capture from camera ──────────────────────────────────────────────────
  Future<void> captureAndScan() async {
    if (cameraController == null || !isCameraReady.value) return;
    if (scanState.value == ScanState.processing) return;

    scanState.value = ScanState.scanning;
    try {
      final XFile image = await cameraController!.takePicture();
      await _processImage(image.path);
    } catch (e) {
      _handleError('Capture failed: $e');
    }
  }

  // ── Pick from gallery ─────────────────────────────────────────────────────
  Future<void> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (image != null) {
      scanState.value = ScanState.scanning;
      await _processImage(image.path);
    }
  }

  // ── OCR processing ────────────────────────────────────────────────────────
  Future<void> _processImage(String imagePath) async {
    scanState.value = ScanState.processing;
    scanProgress.value = 0.0;

    try {
      final inputImage = InputImage.fromFilePath(imagePath);

      for (int i = 1; i <= 5; i++) {
        await Future.delayed(const Duration(milliseconds: 120));
        scanProgress.value = i / 5 * 0.6;
      }

      final RecognizedText recognized =
          await _textRecognizer.processImage(inputImage);

      scanProgress.value = 0.8;

      final model = KhmerIdModel.fromOcrText(recognized.text);
      scanProgress.value = 1.0;

      if (model.isValid) {
        scannedId.value = model;
        scanState.value = ScanState.success;
      } else {
        _handleError(
          'Could not read a valid Khmer ID.\n'
          'Please ensure the card is flat, well-lit, and fully in frame.',
        );
      }
    } catch (e) {
      _handleError('OCR processing failed: $e');
    }
  }

  void _handleError(String msg) {
    errorMessage.value = msg;
    scanState.value = ScanState.error;
    scanProgress.value = 0.0;
  }

  void proceedToProfileForm() {
    if (scannedId.value != null) {
      Get.toNamed(
        AppRoutes.dCompleteForm,
        arguments: scannedId.value,
      );
    }
  }

  void retry() {
    scannedId.value = null;
    errorMessage.value = '';
    scanState.value = ScanState.idle;
    scanProgress.value = 0.0;
  }
}

  

  
