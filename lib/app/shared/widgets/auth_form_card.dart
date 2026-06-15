import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/shared/themes/app_colors.dart';

class AuthFormCard extends StatefulWidget {
  final int itemCount;
  final Widget Function(
    BuildContext context,
    Widget Function(int index, Widget child) staggered,
    Animation<double> pulseAnim,
    Animation<double> shimmerAnim,
  ) builder;

  const AuthFormCard({
    super.key,
    required this.itemCount,
    required this.builder,
  });

  @override
  State<AuthFormCard> createState() => _AuthFormCardState();
}

class _AuthFormCardState extends State<AuthFormCard>
    with TickerProviderStateMixin {
  late AnimationController _staggerCtrl;
  late List<Animation<double>> _fieldFades;
  late List<Animation<Offset>> _fieldSlides;
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;
  late AnimationController _shimmerCtrl;
  late Animation<double> _shimmerAnim;

  @override
  void initState() {
    super.initState();

    _staggerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..forward();

    _fieldFades = List.generate(widget.itemCount, (i) {
      final start = 0.40 + i * 0.07;
      final end = (start + 0.20).clamp(0.0, 1.0);
      return Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _staggerCtrl,
        curve: Interval(start, end, curve: Curves.easeOut),
      ));
    });

    _fieldSlides = List.generate(widget.itemCount, (i) {
      final start = 0.40 + i * 0.07;
      final end = (start + 0.22).clamp(0.0, 1.0);
      return Tween<Offset>(
        begin: const Offset(0, 0.25),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _staggerCtrl,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      ));
    });

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.025).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );

    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
    _shimmerAnim = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _shimmerCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _staggerCtrl.dispose();
    _pulseCtrl.dispose();
    _shimmerCtrl.dispose();
    super.dispose();
  }

  Widget _staggered(int index, Widget child) {
    return FadeTransition(
      opacity: _fieldFades[index],
      child: SlideTransition(
        position: _fieldSlides[index],
        child: child,
      ),
    );
  }

    @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: double.infinity, 
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(36)), // ← all 4 corners
        boxShadow: [
          BoxShadow(
            color: Color(0x1A6A30DE),
            blurRadius: 40,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            // Force minimum height = full screen height
            // so white card ALWAYS fills the screen
            minHeight: screenHeight,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
            child: widget.builder(
              context,
              _staggered,
              _pulseAnim,
              _shimmerAnim,
            ),
          ),
        ),
      ),
    );
  }
}