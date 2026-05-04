
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'detail_book_screen_binding.dart';
part 'detail_book_screen_controller.dart';

class DetailBookScreenView extends GetView<DetailBookScreenController> {
  const DetailBookScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> book = Get.arguments as Map<String, String>;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _BookHeroSection(title: book['title'] ?? ''),
          _BookInfoSection(book: book, controller: controller),
        ],
      ),
    );
  }
}

class _BookHeroSection extends StatelessWidget {
  final String title;
  const _BookHeroSection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          color: Color(0xFF5B33B5),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Book detail',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Review the book detail',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BookInfoSection extends StatelessWidget {
  final Map<String, String> book;
  final DetailBookScreenController controller;

  const _BookInfoSection({required this.book, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFE0D6FF), width: 1.5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book title
            Text(
              book['title'] ?? '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Description
            Text(
              book['desc'] ?? '',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF666666),
                height: 1.6,
              ),
            ),
            SizedBox(height: 20),

            // Rating
            _RatingRow(controller: controller),
            SizedBox(height: 50),
            // Bottom buttons
            _BottomActions(controller: controller),
          ],
        ),
      ),
    );
  }
}

class _RatingRow extends StatelessWidget {
  final DetailBookScreenController controller;
  const _RatingRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rating',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Obx(
          () => Row(
            children: [
              ...List.generate(5, (index) {
                final int starNumber = index + 1;
                final bool filled =
                    starNumber <= controller.selectedRating.value;
                return GestureDetector(
                  onTap: () => controller.onRatingTap(starNumber),
                  child: Icon(
                    filled ? Icons.star_rounded : Icons.star_border_rounded,
                    color: filled ? Color(0xFFFFC107) : Colors.grey,
                    size: 32,
                  ),
                );
              }),
              SizedBox(width: 10),

              Text(
                controller.selectedRating.value == 0
                    ? 'Tap to rate'
                    : '${controller.selectedRating.value}.0',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: controller.selectedRating.value == 0
                      ? Color(0xFF9F9DA4)
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BottomActions extends StatelessWidget {
  final DetailBookScreenController controller;
  const _BottomActions({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: controller.onReadTap,
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: Color(0xFF5B33B5),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Read me',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 8),

        Obx(
          () => _CircleIconButton(
            icon: controller.isDownloaded.value
                ? Icons.download_done_rounded
                : Icons.download_outlined,
            onTap: controller.onDownloadTap,
            isActive: controller.isDownloaded.value,
            activeColor: Color(0xFF5B33B5),
          ),
        ),
        SizedBox(width: 10),

        Obx(
          () => _CircleIconButton(
            icon: controller.isFavorited.value
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded,
            onTap: controller.onFavoriteTap,
            isActive: controller.isFavorited.value,
            activeColor: Color(0xFFC0184A),
          ),
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isActive;
  final Color activeColor;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    this.isActive = false,
    this.activeColor = const Color(0xFF5B33B5),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: isActive ? activeColor.withOpacity(0.12) : Color(0xFFF2EEFF),
          shape: BoxShape.circle,
          border: isActive
              ? Border.all(color: activeColor, width: 1.5)
              : Border.all(color: Color(0xFFE0D6FF), width: 1.5),
        ),
        child: Icon(
          icon,
          color: isActive ? activeColor : Color(0xFF5B33B5),
          size: 22,
        ),
      ),
    );
  }
}
