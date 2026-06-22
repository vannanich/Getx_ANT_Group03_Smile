import 'package:get/get.dart';

class Doctor {
  final String name;
  final String specialty;
  final String subSpecialty;
  final double rating;
  final String imagePath;

  Doctor({
    required this.name,
    required this.specialty,
    required this.subSpecialty,
    required this.rating,
    required this.imagePath,
  });
}

class ChatWithDoctorController extends GetxController {
  final searchQuery = ''.obs;
  final selectedCategory = 'All'.obs;

  final categories = ['All', 'Therapist', 'Psychologists', 'Diagnosis', 'Cognitive'];

  final doctors = <Doctor>[
    Doctor(name: 'Dr. Tung Tung Sahur', specialty: 'Therapist', subSpecialty: 'Psychologists', rating: 4.5, imagePath: 'assets/images/doctor.jpg'),
    Doctor(name: 'Dr. Tung Tung Sahur', specialty: 'Therapist', subSpecialty: 'Psychologists', rating: 4.5, imagePath: 'assets/images/doctor.jpg'),
    Doctor(name: 'Dr. Tung Tung Sahur', specialty: 'Therapist', subSpecialty: 'Psychologists', rating: 4.5, imagePath: 'assets/images/doctor.jpg'),
    Doctor(name: 'Dr. Tung Tung Sahur', specialty: 'Therapist', subSpecialty: 'Psychologists', rating: 4.5, imagePath: 'assets/images/doctor.jpg'),
  ].obs;

  List<Doctor> get filteredDoctors {
    return doctors.where((d) {
      final matchCategory = selectedCategory.value == 'All' ||
          d.specialty.toLowerCase() == selectedCategory.value.toLowerCase() ||
          d.subSpecialty.toLowerCase() == selectedCategory.value.toLowerCase();
      final matchSearch = searchQuery.value.isEmpty ||
          d.name.toLowerCase().contains(searchQuery.value.toLowerCase());
      return matchCategory && matchSearch;
    }).toList();
  }

  void selectCategory(String cat) => selectedCategory.value = cat;
  void onSearch(String val) => searchQuery.value = val;
}