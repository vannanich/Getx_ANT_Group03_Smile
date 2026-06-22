part of 'docter_check_message_view.dart';

class DocterCheckMessageViewController extends GetxController {
  final searchController = TextEditingController();
  final selectedIndex = 2.obs; // Chat active by default

  final _allPatients = <Map<String, dynamic>>[
    {
      "name": "Arlene McCoy",
      "image": "assets/img/pro1.jpg",
      "lastMessage": "Hi doc🫡",
      "time": "4:30",
      "unread": 1,
    },
    {
      "name": "Ronald Richards",
      "image": "assets/img/pro2.jpg",
      "lastMessage": "How are yo...",
      "time": "4:30",
      "unread": 1,
    },
    {
      "name": "Cody Fisher",
      "image": "assets/img/pro3.jpg",
      "lastMessage": "Please set t...",
      "time": "4:30",
      "unread": 0,
    },
    {
      "name": "Eleanor Pena",
      "image": "assets/img/pro4.jpg",
      "lastMessage": "I wanna se...",
      "time": "4:30",
      "unread": 1,
    },
  ].obs;

  final filteredPatients = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredPatients.assignAll(_allPatients);
  }

  void searchPatient(String query) {
    if (query.isEmpty) {
      filteredPatients.assignAll(_allPatients);
    } else {
      filteredPatients.assignAll(
        _allPatients.where((p) =>
            p["name"].toString().toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  void changeTab(int index) => selectedIndex.value = index;

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }



  //   void openChat(int index) {
  //   // ✅ Reset unread count to 0
  //   final patient = Map<String, dynamic>.from(filteredPatients[index]);
  //   patient["unread"] = 0;
  //   filteredPatients[index] = patient;

  //   // Also update in _allPatients
  //   final originalIndex = _allPatients.indexWhere(
  //     (p) => p["name"] == filteredPatients[index]["name"],
  //   );
  //   if (originalIndex != -1) {
  //     final original = Map<String, dynamic>.from(_allPatients[originalIndex]);
  //     original["unread"] = 0;
  //     _allPatients[originalIndex] = original;
  //   }

  //   // Navigate to chat screen
  //   Get.toNamed(AppRoutes.chatwithpatientScreen, arguments: filteredPatients[index]);
  // }

  void openChat(int index) {
    filteredPatients[index]["unread"] = 0;
    filteredPatients.refresh(); // VERY IMPORTANT

    Get.to(() => ChatWithPatientScreenView(
      patientName: filteredPatients[index]["name"],
    ));
  }
}
