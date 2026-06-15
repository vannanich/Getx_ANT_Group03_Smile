import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/shared/themes/app_colors.dart';
import 'package:flutter_application_1/app/shared/widgets/animated_logo.dart';

class AuthAnimatedScaffold extends StatefulWidget {
  final Widget child;

  const AuthAnimatedScaffold({
    super.key,
    required this.child,
  });

  @override
  State<AuthAnimatedScaffold> createState() => _AuthAnimatedScaffoldState();
}

class _AuthAnimatedScaffoldState extends State<AuthAnimatedScaffold>
    with TickerProviderStateMixin {
  late AnimationController _staggerCtrl;
  late Animation<Offset> _cardSlide;
  late Animation<double> _cardFade;
  late AnimationController _blobCtrl;
  late Animation<double> _blobAnim;

  @override
  void initState() {
    super.initState();

    _staggerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..forward();

    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _staggerCtrl,
      curve: const Interval(0.25, 0.65, curve: Curves.easeOutCubic),
    ));

    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _staggerCtrl,
      curve: const Interval(0.20, 0.55, curve: Curves.easeOut),
    ));

    _blobCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..repeat(reverse: true);

    _blobAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _blobCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _staggerCtrl.dispose();
    _blobCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          _AnimatedBlob(animation: _blobAnim),
          SafeArea(
            child: Column(
              children: [
                // ── Logo ──────────────────────────────────────────────────
                const AnimatedAppLogo(),

                // ── White card fills ALL remaining space ──────────────────
                Expanded(
                  child: FadeTransition(
                    opacity: _cardFade,
                    child: SlideTransition(
                      position: _cardSlide,
                      child: widget.child,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Animated background blob ─────────────────────────────────────────────────
class _AnimatedBlob extends StatelessWidget {
  final Animation<double> animation;
  const _AnimatedBlob({required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) => Positioned(
        top: -60 + animation.value * 20,
        right: -80 + animation.value * 15,
        child: Container(
          width: 260,
          height: 260,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.secondary.withOpacity(0.18),
                AppColors.secondary.withOpacity(0.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}