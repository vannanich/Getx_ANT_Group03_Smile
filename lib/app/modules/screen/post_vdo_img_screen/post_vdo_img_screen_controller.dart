// part of 'post_vdo_img_screen_view.dart';

// class PostVdoImgScreenViewController extends GetxController {
//   final ImagePicker _picker = ImagePicker();

//   var selectedImagePath = ''.obs;
//   var selectedVideoPath = ''.obs;

//   Future<void> pickImage() async {
//     final XFile? image = await _picker.pickImage(
//       source: ImageSource.gallery,
//     );

//     if (image != null) {
//       selectedImagePath.value = image.path;
//       print("Image: ${image.path}");
//     }
//   }

//   Future<void> pickVideo() async {
//     final XFile? video = await _picker.pickVideo(
//       source: ImageSource.gallery,
//     );

//     if (video != null) {
//       selectedVideoPath.value = video.path;
//       print("Video: ${video.path}");
//     }
//   }
// }

part of 'post_vdo_img_screen_view.dart';

class PostVdoImgScreenViewController extends GetxController {
  final ImagePicker picker = ImagePicker();

  RxString selectedImagePath = ''.obs;
  RxString selectedVideoPath = ''.obs;

  final TextEditingController captionController =
      TextEditingController();

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      selectedImagePath.value = image.path;
      selectedVideoPath.value = '';
    }
  }

  Future<void> pickVideo() async {
    final XFile? video = await picker.pickVideo(
      source: ImageSource.gallery,
    );

    if (video != null) {
      selectedVideoPath.value = video.path;
      selectedImagePath.value = '';
    }
  }

  void submitPost() {
    print("Caption: ${captionController.text}");
    print("Image: ${selectedImagePath.value}");
    print("Video: ${selectedVideoPath.value}");
  }

  @override
  void onClose() {
    captionController.dispose();
    super.onClose();
  }
}