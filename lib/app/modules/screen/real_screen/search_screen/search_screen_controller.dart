// part of 'search_screen_view.dart';

// class SearchScreenViewController extends GetxController {
//   final SearchCtl = TextEditingController();
//   final selectedIndex = 0.obs;

//   void changeTab(int index) {
//     selectedIndex.value = index;
    
//   }

//   void onSearchChanged(String value) {
//     // Handle search logic here
//     print(value);
//   }

//   @override
//   void onInit() {
//     super.onInit();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// class SearchScreenViewController extends GetxController {
//   final TextEditingController textController = TextEditingController();
//   final searchQuery = ''.obs;

//   final RxList<String> recentSearches = <String>[].obs;

//   final box = GetStorage();
//   final String storageKey = "recent_searches";

//   final List<Map<String, String>> allData = [
//     {'title': 'How to be happy', 'subtitle': 'Mental wellness • 7 min'},
//     {'title': 'How to be calm', 'subtitle': 'Meditation • 4 min'},
//     {'title': 'How to be confident', 'subtitle': 'Self growth • 6 min'},
//     {'title': 'How to be productive', 'subtitle': 'Work life • 8 min'},
//     {'title': 'How to stop overthinking', 'subtitle': 'Mindset • 6 min'},
//     {'title': 'Morning motivation', 'subtitle': 'Lifestyle • 5 min'},
//   ];

//   final RxList<Map<String, String>> results =
//       <Map<String, String>>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadHistory();
//   }

//   // ───────── LOAD HISTORY ─────────
//   void loadHistory() {
//     final stored = box.read<List>(storageKey);

//     if (stored != null) {
//       recentSearches.assignAll(stored.map((e) => e.toString()).toList());
//     }
//   }

//   // ───────── SAVE HISTORY ─────────
//   void saveHistory() {
//     box.write(storageKey, recentSearches.toList());
//   }

//   // ───────── ADD SEARCH TO HISTORY ─────────
//   void addToHistory(String query) {
//     if (query.trim().isEmpty) return;

//     // remove duplicate
//     recentSearches.remove(query);

//     // add to top
//     recentSearches.insert(0, query);

//     // limit to 10 items
//     if (recentSearches.length > 10) {
//       recentSearches.removeLast();
//     }

//     saveHistory();
//   }

//   // ───────── SEARCH ─────────
//   void onSearchChanged(String value) {
//     searchQuery.value = value;

//     final q = value.toLowerCase().trim();

//     if (q.isEmpty) {
//       results.clear();
//       return;
//     }

//     results.value = allData.where((item) {
//       return item['title']!.toLowerCase().contains(q) ||
//           item['subtitle']!.toLowerCase().contains(q);
//     }).toList();
//   }

//   // ───────── WHEN USER TAP RESULT ─────────
//   void onResultTap(Map<String, String> item) {
//     final title = item['title']!;

//     textController.text = title;
//     addToHistory(title); // ⭐ SAVE HERE

//     Get.snackbar("Saved", "Added to history");
//   }

//   // ───────── TAP RECENT ITEM ─────────
//   void onRecentItemTap(String label) {
//     textController.text = label;
//     onSearchChanged(label);
//   }

//   // ───────── CLEAR HISTORY ─────────
//   void clearHistory() {
//     recentSearches.clear();
//     box.remove(storageKey);
//   }

//   void clearSearch() {
//     textController.clear();
//     searchQuery.value = '';
//     results.clear();
//   }

//   @override
//   void onClose() {
//     textController.dispose();
//     super.onClose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreenViewController extends GetxController {
  // Reactive search query
  var searchQuery = ''.obs;

  // Text controller for the search bar
  final textController = TextEditingController();

  // Recent searches
  var recentSearches = <String>[
    "Life",
    "How to be happy",
    "Dr. tung tung sahur"
  ].obs;

  // Example data for search results
  var allResults = <Map<String, String>>[
    {"title": "Life Lessons", "subtitle": "Motivational video"},
    {"title": "How to be happy", "subtitle": "Tips and tricks"},
    {"title": "Motivation Reel", "subtitle": "Daily inspiration"},
  ];

  // Filtered results based on query
  List<Map<String, String>> get filteredResults {
    if (searchQuery.value.isEmpty) return [];
    return allResults
        .where((item) =>
            item['title']!.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  // Bottom navigation index
  var selectedIndex = 0.obs;

  // Methods
  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  void clearSearch() {
    textController.clear();
    searchQuery.value = '';
  }

  void onRecentItemTap(String label) {
    textController.text = label;
    searchQuery.value = label;
  }

  void onResultTap(Map<String, String> item) {
    // Handle navigation or action when a result is tapped
    Get.snackbar("Selected", item['title'] ?? "No title");
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
