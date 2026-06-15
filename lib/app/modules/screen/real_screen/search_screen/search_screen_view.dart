import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/real_screen/search_screen/search_screen_controller.dart';
import 'package:flutter_application_1/app/shared/themes/app_colors.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

part 'search_screen_binding.dart';

class SearchScreenView extends GetView<SearchScreenViewController> {
  const SearchScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                Expanded(
                  child: Obx(() => controller.searchQuery.value.isEmpty
                      ? _buildRecentSearch()
                      : _buildSearchResults()),
                ),
              ],
            ),
            _buildFAB(),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomNavigation(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.arrow_back,
                  size: 26, color: Colors.black87),
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search',
                    style: GoogleFonts.balsamiqSans(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Browse your reel',
                    style: GoogleFonts.balsamiqSans(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSearchBar(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller.textController,
        onChanged: controller.onSearchChanged,
        decoration: InputDecoration(
          prefixIcon:
              Icon(Icons.search, color: Colors.purple.shade400, size: 20),
          suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
              ? GestureDetector(
                  onTap: controller.clearSearch,
                  child:
                      Icon(Icons.close, color: Colors.grey.shade400, size: 18),
                )
              : const SizedBox.shrink()),
          hintText: 'motivation...',
          hintStyle: GoogleFonts.balsamiqSans(
              fontSize: 14, color: Colors.grey.shade400),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 13),
        ),
        style: GoogleFonts.balsamiqSans(fontSize: 14, color: Colors.black87),
      ),
    );
  }

  Widget _buildRecentSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Search',
            style: GoogleFonts.balsamiqSans(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...controller.recentSearches.map((item) => _buildRecentItem(item)),
        ],
      ),
    );
  }

  Widget _buildRecentItem(String label) {
    return GestureDetector(
      onTap: () => controller.onRecentItemTap(label),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(Icons.access_time, size: 18, color: Colors.grey.shade500),
            const SizedBox(width: 14),
            Text(label,
                style: GoogleFonts.balsamiqSans(
                    fontSize: 14, color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    final results = controller.filteredResults;

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 48, color: Colors.grey.shade300),
            const SizedBox(height: 12),
            Text(
              'No results found',
              style: GoogleFonts.balsamiqSans(
                  fontSize: 15, color: Colors.grey.shade400),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
      itemCount: results.length,
      separatorBuilder: (_, __) =>
          Divider(color: Colors.grey.shade200, height: 1),
      itemBuilder: (_, i) => _buildResultItem(results[i]),
    );
  }

  Widget _buildResultItem(Map<String, String> item) {
    final query = controller.searchQuery.value.toLowerCase();
    final title = item['title']!;
    final subtitle = item['subtitle']!;
    final matchStart = title.toLowerCase().indexOf(query);

    return GestureDetector(
      onTap: () => controller.onResultTap(item),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.play_circle_outline,
                  color: Colors.purple.shade400, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  matchStart >= 0
                      ? RichText(
                          text: TextSpan(
                            style: GoogleFonts.balsamiqSans(
                                fontSize: 14, color: Colors.black87),
                            children: [
                              TextSpan(text: title.substring(0, matchStart)),
                              TextSpan(
                                text: title.substring(
                                    matchStart, matchStart + query.length),
                                style: GoogleFonts.balsamiqSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ),
                              ),
                              TextSpan(
                                  text: title
                                      .substring(matchStart + query.length)),
                            ],
                          ),
                        )
                      : Text(
                          title,
                          style: GoogleFonts.balsamiqSans(
                              fontSize: 14, color: Colors.black87),
                        ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: GoogleFonts.balsamiqSans(
                        fontSize: 12, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
            Icon(Icons.north_west, size: 16, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return Positioned(
      right: 16,
      bottom: 90,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(Icons.menu, color: Colors.black87, size: 20),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    final List<Map<String, dynamic>> navItems = [
      {"image": "assets/img/home.png", "label": "Home"},
      {"image": "assets/img/chart_success.png", "label": "Chat"},
      {"image": "assets/img/video-play.png", "label": "Video"},
      {"image": "assets/img/profile.png", "label": "Profile"},
    ];

    return Container(
      height: 70,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE5E5),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(navItems.length, (index) {
            final isActive = controller.selectedIndex.value == index;

            return GestureDetector(
              onTap: () => controller.changeTab(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(
                  horizontal: isActive ? 20 : 12,
                  vertical: isActive ? 14 : 10,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.purple.withOpacity(0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedScale(
                      duration: const Duration(milliseconds: 300),
                      scale: isActive ? 1.1 : 1.0,
                      child: Image.asset(
                        navItems[index]["image"],
                        width: 24,
                        height: 24,
                        color: isActive ? Colors.purple : Colors.grey.shade600,
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SizeTransition(
                            sizeFactor: animation,
                            axis: Axis.horizontal,
                            child: child,
                          ),
                        );
                      },
                      child: isActive
                          ? Padding(
                              key: ValueKey(index),
                              padding: const EdgeInsets.only(left: 8),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  navItems[index]["label"],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.balsamiqSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.purple,
                                    height: 1,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
