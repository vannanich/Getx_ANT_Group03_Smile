import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';

class AnimatedAppLogo extends StatefulWidget {
  const AnimatedAppLogo({super.key});

  @override
  State<AnimatedAppLogo> createState() => _AnimatedAppLogoState();
}

class _AnimatedAppLogoState extends State<AnimatedAppLogo>
    with TickerProviderStateMixin {
  // ── Controllers ───────────────────────────────────────────────────────────
  late AnimationController _floatCtrl;
  late AnimationController _orbitCtrl;
  late AnimationController _staggerCtrl;

  late Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();

    // Stagger (for initial entrance)
    _staggerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..forward();

    // Floating animation
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _floatAnim = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );

    // Orbiting stars
    _orbitCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000),
    )..repeat();
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    _orbitCtrl.dispose();
    _staggerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logoFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _staggerCtrl,
        curve: const Interval(0.0, 0.40, curve: Curves.easeOut),
      ),
    );

    final logoScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _staggerCtrl,
        curve: const Interval(0.0, 0.45, curve: Curves.elasticOut),
      ),
    );

    return FadeTransition(
      opacity: logoFade,
      child: ScaleTransition(
        scale: logoScale,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 36),
          child: Column(
            children: [
              AnimatedBuilder(
                animation: Listenable.merge([_floatAnim, _orbitCtrl]),
                builder: (_, __) => Transform.translate(
                  offset: Offset(0, _floatAnim.value),
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Glow ring
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.secondary.withOpacity(0.22),
                                AppColors.secondary.withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                        // Main circle
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.secondary.withOpacity(0.25),
                                blurRadius: 24,
                                spreadRadius: 2,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.nightlight_round,
                              size: 46,
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                        // Orbiting star 1
                        Transform.rotate(
                          angle: _orbitCtrl.value * 2 * math.pi,
                          child: Transform.translate(
                            offset: const Offset(44, 0),
                            child: Transform.rotate(
                              angle: -_orbitCtrl.value * 2 * math.pi,
                              child: Icon(Icons.star,
                                  size: 13,
                                  color: AppColors.secondary.withOpacity(0.75)),
                            ),
                          ),
                        ),
                        // Orbiting star 2
                        Transform.rotate(
                          angle: _orbitCtrl.value * 2 * math.pi + math.pi * 0.7,
                          child: Transform.translate(
                            offset: const Offset(38, 0),
                            child: Transform.rotate(
                              angle: -(_orbitCtrl.value * 2 * math.pi +
                                  math.pi * 0.7),
                              child: Icon(Icons.star,
                                  size: 9,
                                  color: AppColors.icons.withOpacity(0.5)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'smile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondary,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}