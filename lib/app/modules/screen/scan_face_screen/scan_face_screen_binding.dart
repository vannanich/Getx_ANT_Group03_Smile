part of 'scan_face_screen_view.dart';

class ScanFaceScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanFaceScreenViewController>(
      () => ScanFaceScreenViewController(),
    );
  }
}
