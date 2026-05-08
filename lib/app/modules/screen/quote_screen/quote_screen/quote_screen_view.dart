// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'quote_screen_binding.dart';
part 'quote_screen_controller.dart';

class QuoteScreenView extends GetView<QuoteScreenController> {
  const QuoteScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _QuoteAppBar(onShare: controller.onShare),
      body: Obx(() {
        final quote = controller.currentQuote;
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: _QuoteBackground(
            key: ValueKey(controller.currentIndex.value),
            imageUrl: quote.imageUrl,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    Spacer(),
                    _QuoteCard(
                      quoteText: quote.text,
                      author: quote.author,
                      likes: quote.likes,
                      downloads: quote.downloads,
                      shares: quote.shares,
                    ),
                    SizedBox(height: 28),
                    _BottomActions(
                      isLiked: controller.isLiked.value,
                      onDownload: controller.onDownload,
                      onLike: controller.toggleLike,
                    ),
                    SizedBox(height: 20),
                    _NavigationArrows(
                      onPrevious: controller.previousQuote,
                      onNext: controller.nextQuote,
                      canGoPrevious: controller.canGoPrevious,
                      canGoNext: controller.canGoNext,
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _QuoteAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onShare;

  const _QuoteAppBar({required this.onShare});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Read Quotes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Read some quotes to motivate yourself',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      actions: [
        _CircleIconButton(icon: Icons.share_outlined, onTap: onShare),
        SizedBox(width: 8),
        _CircleIconButton(icon: Icons.image_outlined, onTap: () {}),
        SizedBox(width: 12),
      ],
    );
  }
}

class _QuoteBackground extends StatelessWidget {
  final String imageUrl;
  final Widget child;

  const _QuoteBackground({
    super.key,
    required this.imageUrl,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
          // ignore: unnecessary_underscores
          errorBuilder: (_, __, ___) => Container(color: Color(0xFF1a2a1a)),
        ),
        Container(color: Colors.black.withOpacity(0.30)),
        child,
      ],
    );
  }
}

class _QuoteCard extends StatelessWidget {
  final String quoteText;
  final String author;
  final int likes;
  final int downloads;
  final int shares;

  const _QuoteCard({
    required this.quoteText,
    required this.author,
    required this.likes,
    required this.downloads,
    required this.shares,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.38),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.12)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _QuoteText(text: quoteText, author: author),
              SizedBox(height: 24),
              _StatsRow(likes: likes, downloads: downloads, shares: shares),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuoteText extends StatelessWidget {
  final String text;
  final String author;

  const _QuoteText({required this.text, required this.author});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            height: 1.45,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 16),
        Text(
          author,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  final int likes;
  final int downloads;
  final int shares;

  const _StatsRow({
    required this.likes,
    required this.downloads,
    required this.shares,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _StatItem(icon: Icons.favorite_border, count: likes),
        SizedBox(width: 24),
        _StatItem(icon: Icons.download_outlined, count: downloads),
        SizedBox(width: 24),
        _StatItem(icon: Icons.share_outlined, count: shares),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final int count;

  const _StatItem({required this.icon, required this.count});

  String _format(int n) =>
      n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}k' : '$n';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        SizedBox(width: 6),
        Text(
          _format(count),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _BottomActions extends StatelessWidget {
  final bool isLiked;
  final VoidCallback onDownload;
  final VoidCallback onLike;

  const _BottomActions({
    required this.isLiked,
    required this.onDownload,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _CircleIconButton(icon: Icons.download_outlined, onTap: onDownload),
        SizedBox(width: 24),
        _CircleIconButton(
          icon: isLiked ? Icons.favorite : Icons.favorite_border,
          onTap: onLike,
          iconColor: isLiked ? Colors.redAccent : Colors.white,
        ),
      ],
    );
  }
}

class _NavigationArrows extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool canGoPrevious;
  final bool canGoNext;

  const _NavigationArrows({
    required this.onPrevious,
    required this.onNext,
    required this.canGoPrevious,
    required this.canGoNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _CircleIconButton(
          icon: Icons.arrow_back,
          onTap: canGoPrevious ? onPrevious : null,
          opacity: canGoPrevious ? 1.0 : 0.35,
        ),
        _CircleIconButton(
          icon: Icons.arrow_forward,
          onTap: canGoNext ? onNext : null,
          opacity: canGoNext ? 1.0 : 0.35,
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color iconColor;
  final double opacity;

  const _CircleIconButton({
    required this.icon,
    this.onTap,
    this.iconColor = Colors.white,
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Color(0x66555555),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
      ),
    );
  }
}
