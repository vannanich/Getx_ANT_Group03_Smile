part of 'scan_face_screen_view.dart';

class ScanFaceScreenViewController extends GetxController {
  CameraController? cameraController;
  final isCameraReady = false.obs;
  final isScanning = false.obs;
  final scanLinePosition = 20.0.obs;

  @override
  void onInit() {
    super.onInit();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      Get.snackbar(
        "Permission Denied",
        "Camera access is required to scan your face.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await cameraController!.initialize();
      isCameraReady.value = true;
    } catch (e) {
      debugPrint('Camera init error: $e');
    }
  }

  Future<void> startScan() async {
    if (!isCameraReady.value) return;

    isScanning.value = true;
    _animateScanLine();

    await Future.delayed(const Duration(seconds: 3));

    isScanning.value = false;
    scanLinePosition.value = 20.0;

    Get.snackbar(
      "Scan Complete",
      "Your mood has been reviewed! 😊",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF5B3EFF),
      colorText: Colors.white,
    );
  }

  void _animateScanLine() async {
    const double top = 20.0;
    const double bottom = 260.0;
    bool goingDown = true;

    while (isScanning.value) {
      await Future.delayed(const Duration(milliseconds: 16));
      if (!isScanning.value) break;

      if (goingDown) {
        scanLinePosition.value += 2.5;
        if (scanLinePosition.value >= bottom) goingDown = false;
      } else {
        scanLinePosition.value -= 2.5;
        if (scanLinePosition.value <= top) goingDown = true;
      }
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
