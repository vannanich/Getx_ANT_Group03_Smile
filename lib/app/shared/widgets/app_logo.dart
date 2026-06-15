// lib/app/shared/widgets/app_logo.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/shared/themes/app_colors.dart';

class AppLogo extends StatefulWidget {
  /// Size of the circular container. Default: 120.
  final double size;

  /// Whether to animate the logo floating up and down. Default: true.
  final bool animated;

  const AppLogo({
    super.key,
    this.size = 120,
    this.animated = true,
  });

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> with SingleTickerProviderStateMixin {
  late AnimationController _floatCtrl;
  late Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _floatAnim = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );

    if (widget.animated) {
      _floatCtrl.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final double imageSize = size * 0.65;
    final double fontSize = size * 0.13;

    Widget logo = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.secondary.withOpacity(0.15),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              'assets/logo.png', // ← replace with your actual logo asset path
              width: imageSize,
              height: imageSize,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: size * 0.08),
        Text(
          'smile', // ← replace with your app name if needed
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: AppColors.secondary,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );

    if (!widget.animated) return logo;

    return AnimatedBuilder(
      animation: _floatAnim,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, _floatAnim.value),
        child: child,
      ),
      child: logo,
    );
  }
}