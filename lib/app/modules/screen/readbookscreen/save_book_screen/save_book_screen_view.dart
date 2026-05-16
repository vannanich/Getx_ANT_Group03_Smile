// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/mood_selection/widget/categoriesWidget.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../read_book_screen/read_book_screen_view.dart';

part 'save_book_screen_binding.dart';
part 'save_book_screen_controller.dart';

class SaveBookScreenView extends StatelessWidget {
  const SaveBookScreenView({super.key});

  static const List<Map<String, String>> allBooks = [
    {
      'title': 'Hooked',
      'desc': 'Learn how to create habit-forming experiences',
    },
    {
      'title': 'Atomic Habits',
      'desc': 'Tiny changes that deliver remarkable results',
    },
    {
      'title': 'Deep Work',
      'desc': 'Rules for focused success in a distracted world',
    },
    {
      'title': 'Zero to One',
      'desc': 'Build the future from nothing to something',
    },
    {
      'title': 'Thinking Fast & Slow',
      'desc': 'The two systems that drive how we think',
    },
    {
      'title': 'The Lean Startup',
      'desc': 'How entrepreneurs use continuous innovation',
    },
    {
      'title': 'The Lean Startup',
      'desc': 'How entrepreneurs use continuous innovation',
    },
    {
      'title': 'Thinking Fast & Slow',
      'desc': 'The two systems that drive how we think',
    },
    {
      'title': 'The Lean Startup',
      'desc': 'How entrepreneurs use continuous innovation',
    },
    {
      'title': 'The Lean Startup',
      'desc': 'How entrepreneurs use continuous innovation',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final readController = Get.find<ReadBookScreenController>();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Book saved",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 3),
            Text("Review your favourite book", style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 45),
            _buildSearch(),
            SizedBox(height: 20),
            Categorieswidget(
              categories: [
                'All',
                'Motivation',
                'Self improvement',
                'Psychology',
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                final savedIndexes = readController.savedBooks;

                if (savedIndexes.isEmpty) {
                  return _buildEmptyState(
                    "Opp!! It's Empty",
                    "Look like you don't have any saved book.",
                  );
                }

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: savedIndexes.length,
                  itemBuilder: (context, i) {
                    final bookIndex = savedIndexes[i];
                    final book = allBooks[bookIndex];
                    return GestureDetector(
                      onTap: () => Get.toNamed("/detailbook", arguments: book),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFFE6DAFE),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF5B33B5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () => readController
                                          .toggleFavorite(bookIndex),
                                      child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.85),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.favorite_rounded,
                                          size: 18,
                                          color: Color(0xFFC0184A),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              book['title']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              book['desc']!,
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF9F9DA4),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: "Browse your book",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 3, color: Color(0xFFDDDDDD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1.5, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 40),
          Lottie.network(
            'https://assets10.lottiefiles.com/packages/lf20_hl5n0bwb.json',
            width: 260,
            height: 260,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Color(0xFF9F9DA4)),
            ),
          ),
        ],
      ),
    );
  }
}
