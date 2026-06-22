part of 'patient_list_screen_view.dart';

class PatientListScreenViewController extends GetxController {
  // RxInt selectedIndex = 0.obs;
  // final pageController = PageController();

  // void changeTab(int index) {
  //   selectedIndex.value = index;

  //   pageController.animateToPage(
  //     index,
  //     duration: const Duration(milliseconds: 350),
  //     curve: Curves.easeInOut,
  //   );
  // }
  final selectedIndex = 0.obs;

  final searchController = TextEditingController();

  final List<Map<String, String>> allPatients = [
    {"name": "Arlene McCoy", "image": "assets/img/pro1.jpg"},
    {"name": "Darrell Steward", "image": "assets/img/pro2.jpg"},
    {"name": "Devon Lane", "image": "assets/img/pro3.jpg"},
    {"name": "Cameron Williamson", "image": "assets/img/pro4.jpg"},
    {"name": "Ralph Edwards", "image": "assets/img/pro5.jpg"},
    {"name": "Floyd Miles", "image": "assets/img/pro6.jpg"},
    {"name": "Brooklyn Simmons", "image": "assets/img/pro7.jpg"},
    {"name": "Jacob Jones", "image": "assets/img/pro8.jpg"},
  ];

  final filteredPatients = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredPatients.assignAll(allPatients);
  }

  void searchPatient(String query) {
    if (query.isEmpty) {
      filteredPatients.assignAll(allPatients);
    } else {
      filteredPatients.assignAll(
        allPatients.where((patient) {
          final name = patient["name"]!.toLowerCase();
          return name.contains(query.toLowerCase());
        }).toList(),
      );
    }
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

}