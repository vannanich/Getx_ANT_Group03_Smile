part of 'choose_profile_screen_view.dart';

class ChooseProfileScreenViewController extends GetxController {
  final pickedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (image != null) {
        pickedImage.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image. Please try again.',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red,
      );
      debugPrint('Image pick error: $e');
    }
  }
}