import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/app/core/widgets/animated_logo.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // ── Controllers ──────────────────────────────
  late AnimationController _contentCtrl;
  late AnimationController _quoteCtrl;
  late AnimationController _progressCtrl;

  // ── Brand tagline ─────────────────────────────
  late Animation<double> _brandOpacity;
  late Animation<Offset> _brandSlide;

  // ── Quote card ───────────────────────────────
  late Animation<double> _quoteOpacity;
  late Animation<Offset> _quoteSlide;

  // ── Progress ─────────────────────────────────
  late Animation<double> _progressOpacity;
  double _loadProgress = 0.0;

  // ── Quotes ───────────────────────────────────
  final List<Map<String, String>> _quotes = [
    {
      'text': '"The secret of getting ahead is getting started."',
      'author': '— Mark Twain',
    },
    {
      'text': '"Push yourself, because no one else is going to do it for you."',
      'author': '— Smile',
    },
    {
      'text': '"Believe you can and you\'re halfway there."',
      'author': '— Theodore Roosevelt',
    },
  ];
  late Map<String, String> _selectedQuote;

  @override
  void initState() {
    super.initState();

    _selectedQuote = _quotes[DateTime.now().millisecond % _quotes.length];

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    _setupAnimations();
    _startSequence();
  }

  void _setupAnimations() {
    // Brand tagline slide up
    _contentCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _brandOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentCtrl, curve: Curves.easeOut),
    );
    _brandSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _contentCtrl, curve: Curves.easeOut));

    // Quote card
    _quoteCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _quoteOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _quoteCtrl, curve: Curves.easeOut),
    );
    _quoteSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _quoteCtrl, curve: Curves.easeOut));

    // Progress bar fade in
    _progressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _progressOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressCtrl, curve: Curves.easeOut),
    );
  }

  Future<void> _startSequence() async {
    // AnimatedAppLogo handles its own entrance animation
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    _contentCtrl.forward();

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    _quoteCtrl.forward();

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    _progressCtrl.forward();
    _simulateLoading();
  }

  void _simulateLoading() {
    const totalMs = 5000; // 5 seconds
    const tickMs = 80;
    int elapsed = 0;

    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: tickMs));
      elapsed += tickMs;
      if (!mounted) return false;

      setState(() {
        _loadProgress = (elapsed / totalMs).clamp(0.0, 1.0);
      });

      if (elapsed >= totalMs) {
        await Future.delayed(const Duration(milliseconds: 300));
        if (mounted) {
          Get.offAllNamed(AppRoutes.selectRoleScreen);
        }
        return false;
      }
      return true;
    });
  }

  @override
  void dispose() {
    _contentCtrl.dispose();
    _quoteCtrl.dispose();
    _progressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildBgBlobs(),
            Column(
              children: [
                const Spacer(flex: 2),

                // Logo — AnimatedAppLogo handles float + orbit + entrance
                const AnimatedAppLogo(),

                const SizedBox(height: 12),

                // Tagline slides up after logo appears
                FadeTransition(
                  opacity: _brandOpacity,
                  child: SlideTransition(
                    position: _brandSlide,
                    child: Text(
                      'FUEL YOUR POTENTIAL',
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 2,
                        color: AppColors.textLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                // Quote card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: FadeTransition(
                    opacity: _quoteOpacity,
                    child: SlideTransition(
                      position: _quoteSlide,
                      child: _buildQuoteCard(),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // Progress bar
                FadeTransition(
                  opacity: _progressOpacity,
                  child: _buildProgressBar(),
                ),

                const SizedBox(height: 36),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBgBlobs() {
    return Stack(
      children: [
        Positioned(
          top: -60,
          right: -60,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondary.withOpacity(0.06),
            ),
          ),
        ),
        Positioned(
          bottom: -40,
          left: -50,
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondary.withOpacity(0.07),
            ),
          ),
        ),
        Positioned(
          top: 180,
          left: 20,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondary.withOpacity(0.05),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuoteCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 3,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _selectedQuote['text']!,
            style: const TextStyle(
              fontSize: 13,
              height: 1.7,
              color: AppColors.textMid,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _selectedQuote['author']!,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        SizedBox(
          width: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _loadProgress,
              minHeight: 2.5,
              backgroundColor: AppColors.border,
              valueColor:
                  AlwaysStoppedAnimation<Color>(AppColors.secondary),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _loadProgress >= 1.0 ? 'ready' : 'loading',
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.textLight,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}