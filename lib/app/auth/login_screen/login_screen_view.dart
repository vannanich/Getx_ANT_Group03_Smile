import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/auth/login_screen/login_screen_controller.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:flutter_application_1/app/shared/themes/app_colors.dart';
import 'package:get/get.dart';


class LoginScreenView extends GetView<LoginScreenController> {
  const LoginScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SignInAnimatedScaffold();
  }
}

class _SignInAnimatedScaffold extends StatefulWidget {
  const _SignInAnimatedScaffold();

  @override
  State<_SignInAnimatedScaffold> createState() =>
      _SignInAnimatedScaffoldState();
}

class _SignInAnimatedScaffoldState extends State<_SignInAnimatedScaffold>
    with TickerProviderStateMixin {
  // ── Master stagger controller ───────────────────────────────────────────────
  late AnimationController _staggerCtrl;

  // ── Floating logo controller ────────────────────────────────────────────────
  late AnimationController _floatCtrl;
  late Animation<double> _floatAnim;

  // ── Orbiting star controller ────────────────────────────────────────────────
  late AnimationController _orbitCtrl;

  // ── Card slide-up ──────────────────────────────────────────────────────────
  late Animation<Offset> _cardSlide;
  late Animation<double> _cardFade;

  // ── Staggered field animations ─────────────────────────────────────────────
  late List<Animation<double>> _fieldFades;
  late List<Animation<Offset>> _fieldSlides;

  // ── Button pulse ───────────────────────────────────────────────────────────
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  // ── Shimmer on social row ──────────────────────────────────────────────────
  late AnimationController _shimmerCtrl;
  late Animation<double> _shimmerAnim;

  // ── Background blob ────────────────────────────────────────────────────────
  late AnimationController _blobCtrl;
  late Animation<double> _blobAnim;

  @override
  void initState() {
    super.initState();

    // ── Stagger (total 1.8 s) ──────────────────────────────────────────────
    _staggerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..forward();

    // ── Float (infinite, 3 s cycle) ────────────────────────────────────────
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
    _floatAnim = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );

    // ── Orbit (infinite, 6 s) ──────────────────────────────────────────────
    _orbitCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000),
    )..repeat();

    // ── Card slide ─────────────────────────────────────────────────────────
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

    // ── Field stagger (6 elements) ─────────────────────────────────────────
    const int fields = 6;
    _fieldFades = List.generate(fields, (i) {
      final start = 0.45 + i * 0.07;
      final end = (start + 0.20).clamp(0.0, 1.0);
      return Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _staggerCtrl,
        curve: Interval(start, end, curve: Curves.easeOut),
      ));
    });
    _fieldSlides = List.generate(fields, (i) {
      final start = 0.45 + i * 0.07;
      final end = (start + 0.22).clamp(0.0, 1.0);
      return Tween<Offset>(
        begin: const Offset(0, 0.25),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _staggerCtrl,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      ));
    });

    // ── Button pulse (infinite) ────────────────────────────────────────────
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.025).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );

    // ── Shimmer (infinite, 2 s) ────────────────────────────────────────────
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
    _shimmerAnim = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _shimmerCtrl, curve: Curves.easeInOut),
    );

    // ── Blob morph (infinite, 5 s) ─────────────────────────────────────────
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
    _floatCtrl.dispose();
    _orbitCtrl.dispose();
    _pulseCtrl.dispose();
    _shimmerCtrl.dispose();
    _blobCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // ── Animated background blob ─────────────────────────────────────
          _AnimatedBlob(animation: _blobAnim),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // ── Logo ─────────────────────────────────────────────────
                  _AnimatedLogo(
                    floatAnim: _floatAnim,
                    orbitCtrl: _orbitCtrl,
                    staggerCtrl: _staggerCtrl,
                  ),

                  // ── Card ──────────────────────────────────────────────────
                  FadeTransition(
                    opacity: _cardFade,
                    child: SlideTransition(
                      position: _cardSlide,
                      child: _FormCard(
                        fieldFades: _fieldFades,
                        fieldSlides: _fieldSlides,
                        pulseAnim: _pulseAnim,
                        shimmerAnim: _shimmerAnim,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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

class _AnimatedLogo extends StatelessWidget {
  final Animation<double> floatAnim;
  final AnimationController orbitCtrl;
  final AnimationController staggerCtrl;

  const _AnimatedLogo({
    required this.floatAnim,
    required this.orbitCtrl,
    required this.staggerCtrl,
  });

  @override
  Widget build(BuildContext context) {
    // Logo fade-in
    final logoFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: staggerCtrl,
        curve: const Interval(0.0, 0.40, curve: Curves.easeOut),
      ),
    );
    final logoScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: staggerCtrl,
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
                animation: Listenable.merge([floatAnim, orbitCtrl]),
                builder: (_, __) => Transform.translate(
                  offset: Offset(0, floatAnim.value),
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
                          child: Center(
                            child: Icon(
                              Icons.nightlight_round,
                              size: 46,
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                        // Orbiting star 1
                        Transform.rotate(
                          angle: orbitCtrl.value * 2 * math.pi,
                          child: Transform.translate(
                            offset: const Offset(44, 0),
                            child: Transform.rotate(
                              angle: -orbitCtrl.value * 2 * math.pi,
                              child: Icon(Icons.star,
                                  size: 13,
                                  color: AppColors.secondary.withOpacity(0.75)),
                            ),
                          ),
                        ),
                        // Orbiting star 2 (offset phase)
                        Transform.rotate(
                          angle: orbitCtrl.value * 2 * math.pi + math.pi * 0.7,
                          child: Transform.translate(
                            offset: const Offset(38, 0),
                            child: Transform.rotate(
                              angle: -(orbitCtrl.value * 2 * math.pi +
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

class _FormCard extends GetView<LoginScreenController> {
  final List<Animation<double>> fieldFades;
  final List<Animation<Offset>> fieldSlides;
  final Animation<double> pulseAnim;
  final Animation<double> shimmerAnim;

  const _FormCard({
    required this.fieldFades,
    required this.fieldSlides,
    required this.pulseAnim,
    required this.shimmerAnim,
  });

  Widget _staggered(int index, Widget child) {
    return FadeTransition(
      opacity: fieldFades[index],
      child: SlideTransition(
        position: fieldSlides[index],
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A6A30DE),
            blurRadius: 40,
            offset: Offset(0, -8),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _staggered(0, _buildHeader()),
          const SizedBox(height: 28),

          // Email
          _staggered(1, Obx(() => _AnimatedInputField(
                controller: controller.emailController,
                hint: 'Email',
                keyboardType: TextInputType.emailAddress,
                errorText: controller.emailError.value.isEmpty
                    ? null
                    : controller.emailError.value,
              ))),
          const SizedBox(height: 14),

          // Password
          _staggered(2, Obx(() => _AnimatedInputField(
                controller: controller.passwordController,
                hint: 'Password',
                obscureText: !controller.isPasswordVisible.value,
                errorText: controller.passwordError.value.isEmpty
                    ? null
                    : controller.passwordError.value,
                suffixIcon: GestureDetector(
                  onTap: controller.togglePasswordVisibility,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, anim) => ScaleTransition(
                      scale: anim,
                      child: child,
                    ),
                    child: Icon(
                      controller.isPasswordVisible.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      key: ValueKey(controller.isPasswordVisible.value),
                      color: AppColors.textLight,
                      size: 20,
                    ),
                  ),
                ),
              ))),
          const SizedBox(height: 8),

          // Forgot password
          _staggered(
            2,
            Align(
              alignment: Alignment.centerRight,
              child: _TapScaleWidget(
                onTap: controller.onForgotPassword,
                child: Text(
                  'Forget password?',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Sign In button
          _staggered(3, _AnimatedSignInButton(
            pulseAnim: pulseAnim,
            onTap: controller.signIn,
          )),
          const SizedBox(height: 12),

          // Guest button
          _staggered(4, _TapScaleWidget(
            onTap: controller.continueAsGuest,
            child: Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.secondary, width: 1.6),
              ),
              child: Center(
                child: Text(
                  'Continue as guest',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ),
          )),
          const SizedBox(height: 20),

          _staggered(
            4,
            Center(
              child: _TapScaleWidget(
                onTap: controller.onSignUp,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.signUp);
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account?  ",
                          style: TextStyle(
                              fontSize: 13, color: AppColors.textLight),
                        ),
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Divider with shimmer
          _staggered(5, _ShimmerDivider(shimmerAnim: shimmerAnim)),
          const SizedBox(height: 20),

          // Social buttons
          _staggered(5, _buildSocialButtons()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.homescreen);
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Sing ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.secondary,
                  ),
                ),
                TextSpan(
                  text: 'In',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Sign In into your exist account',
          style: TextStyle(fontSize: 13, color: AppColors.textLight),
        ),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Column(
      children: [
        _TapScaleWidget(
          onTap: controller.signInWithGoogle,
          child: _SocialTile(
            label: 'Google',
            icon: _GoogleIcon(),
          ),
        ),
        const SizedBox(height: 12),
        _TapScaleWidget(
          onTap: controller.signInWithFacebook,
          child: _SocialTile(
            label: 'Facebook',
            icon: const Icon(Icons.facebook,
                color: Color(0xFF1877F2), size: 24),
          ),
        ),
      ],
    );
  }
}

class _AnimatedSignInButton extends GetView<LoginScreenController> {
  final Animation<double> pulseAnim;
  final VoidCallback onTap;

  const _AnimatedSignInButton({
    required this.pulseAnim,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final loading = controller.isLoading.value;
      return AnimatedBuilder(
        animation: pulseAnim,
        builder: (_, child) => Transform.scale(
          scale: loading ? 1.0 : pulseAnim.value,
          child: child,
        ),
        child: _TapScaleWidget(
          onTap: loading ? null : onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(
                colors: loading
                    ? [
                        AppColors.secondary.withOpacity(0.6),
                        AppColors.icons.withOpacity(0.6),
                      ]
                    : [AppColors.secondary, AppColors.icons],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondary.withOpacity(loading ? 0.1 : 0.40),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: loading
                    ? const SizedBox(
                        key: ValueKey('loader'),
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Sign in',
                        key: ValueKey('label'),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.4,
                        ),
                      ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

// ─── Shimmer Divider ──────────────────────────────────────────────────────────
class _ShimmerDivider extends StatelessWidget {
  final Animation<double> shimmerAnim;
  const _ShimmerDivider({required this.shimmerAnim});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AnimatedBuilder(
            animation: shimmerAnim,
            builder: (_, __) => ShaderMask(
              shaderCallback: (rect) => LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: const [0.0, 0.5, 1.0],
                colors: [
                  AppColors.border,
                  Color.lerp(AppColors.border, AppColors.secondary,
                      ((shimmerAnim.value + 1.5) / 3.0).clamp(0.0, 1.0))!,
                  AppColors.border,
                ],
              ).createShader(rect),
              child: Container(height: 1, color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Or continues with',
            style: TextStyle(fontSize: 12, color: AppColors.textLight),
          ),
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: shimmerAnim,
            builder: (_, __) => ShaderMask(
              shaderCallback: (rect) => LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: const [0.0, 0.5, 1.0],
                colors: [
                  AppColors.border,
                  Color.lerp(AppColors.border, AppColors.secondary,
                      ((shimmerAnim.value + 1.5) / 3.0).clamp(0.0, 1.0))!,
                  AppColors.border,
                ],
              ).createShader(rect),
              child: Container(height: 1, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class _AnimatedInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final String? errorText;

  const _AnimatedInputField({
    required this.controller,
    required this.hint,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.errorText,
  });

  @override
  State<_AnimatedInputField> createState() => _AnimatedInputFieldState();
}

class _AnimatedInputFieldState extends State<_AnimatedInputField>
    with SingleTickerProviderStateMixin {
  late AnimationController _focusCtrl;
  late Animation<double> _borderAnim;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _borderAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _focusCtrl, curve: Curves.easeOut),
    );
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _focusCtrl.forward();
      } else {
        _focusCtrl.reverse();
      }
    });
  }

  @override
  void dispose() {
    _focusCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedBuilder(
          animation: _borderAnim,
          builder: (_, child) => Container(
            decoration: BoxDecoration(
              color: Color.lerp(
                  const Color(0xFFF8FAFC), const Color(0xFFF5F0FF), _borderAnim.value),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hasError
                    ? AppColors.error
                    : Color.lerp(
                        const Color(0xFFE2E8F0),
                        AppColors.secondary,
                        _borderAnim.value,
                      )!,
                width: 1.4 + _borderAnim.value * 0.6,
              ),
              boxShadow: [
                BoxShadow(
                  color: hasError
                      ? AppColors.error.withOpacity(0.08)
                      : AppColors.secondary
                          .withOpacity(0.10 * _borderAnim.value),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: child,
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            style: const TextStyle(fontSize: 14, color: AppColors.textDark),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(fontSize: 14, color: AppColors.textLight),
              suffixIcon: widget.suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 15,
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: hasError
              ? Padding(
                  padding: const EdgeInsets.only(left: 4, top: 5),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline,
                          size: 13, color: AppColors.error),
                      const SizedBox(width: 4),
                      Text(
                        widget.errorText!,
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.error),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

// ─── Tap Scale Widget (press feedback) ───────────────────────────────────────
class _TapScaleWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const _TapScaleWidget({required this.child, this.onTap});

  @override
  State<_TapScaleWidget> createState() => _TapScaleWidgetState();
}

class _TapScaleWidgetState extends State<_TapScaleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

class _SocialTile extends StatelessWidget {
  final String label;
  final Widget icon;

  const _SocialTile({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(painter: _GooglePainter()),
    );
  }
}

class _GooglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;
    final colors = [
      const Color(0xFF4285F4),
      const Color(0xFF34A853),
      const Color(0xFFFBBC05),
      const Color(0xFFEA4335),
    ];
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.22;

    for (int i = 0; i < 4; i++) {
      paint.color = colors[i];
      canvas.drawArc(
        Rect.fromCircle(center: c, radius: r * 0.72),
        (i * 90 - 45) * math.pi / 180,
        85 * math.pi / 180,
        false,
        paint,
      );
    }

    final white = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(
          c.dx, c.dy - size.height * 0.18, size.width * 0.44, size.height * 0.18),
      white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}