import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'read_book_screen_binding.dart';
part 'read_book_screen_controller.dart';

class ReadBookScreenView extends GetView<ReadBookScreenController> {
  const ReadBookScreenView({super.key});

  final List<Map<String, String>> books = const [
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Read Book",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            Text(
              "Read a book to improve yourself",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9F9DA4),
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 40),
                _buildSearch(),
                SizedBox(height: 30),
                _buildSave(),
                SizedBox(height: 25),
                _buildCategories(),
                SizedBox(height: 30),
              ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.6,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final book = books[index];
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
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF5B33B5),
                              borderRadius: BorderRadius.circular(10),
                            ),
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
              }, childCount: books.length),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
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

  Widget _buildSave() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionCard(
          label: 'Book saved',
          icon: Icons.favorite_rounded,
          cardColor: Color(0xFFE6DAFE),
          accentColor: Color(0xFFC0184A),
          badgeCount: 2,
          onTap: () => Get.toNamed("/savebook"),
        ),
        SizedBox(width: 24),
        _buildActionCard(
          label: 'Book downloaded',
          icon: Icons.download_rounded,
          cardColor: Color(0xFFE6DAFE),
          accentColor: Color(0xFF5B33B5),
          badgeCount: 1,
          onTap: () => Get.toNamed("/bookdownload"),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String label,
    required IconData icon,
    required Color cardColor,
    required Color accentColor,
    required int badgeCount,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 175,
        height: 150,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 56, color: accentColor),
            SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final List<String> categories = [
      'All',
      'Motivation',
      'Self improve',
      'Psychology',
    ];
    return Row(
      children: List.generate(categories.length, (index) {
        final bool isSelected = index == 0;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              right: index == categories.length - 1 ? 0 : 8,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFF5B33B5) : Color(0xFFE6DAFE),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              categories[index],
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              textScaler: TextScaler.noScaling,
              maxLines: 1,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Color(0xFF5B33B5),
              ),
            ),
          ),
        );
      }),
    );
  }
}
