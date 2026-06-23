import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';

class AuthShimmerDivider extends StatelessWidget {
  final Animation<double> shimmerAnim;
  const AuthShimmerDivider({super.key, required this.shimmerAnim});

  Widget _line() {
    return Expanded(
      child: AnimatedBuilder(
        animation: shimmerAnim,
        builder: (_, __) => ShaderMask(
          shaderCallback: (rect) => LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: const [0.0, 0.5, 1.0],
            colors: [
              AppColors.border,
              Color.lerp(
                AppColors.border,
                AppColors.secondary,
                ((shimmerAnim.value + 1.5) / 3.0).clamp(0.0, 1.0),
              )!,
              AppColors.border,
            ],
          ).createShader(rect),
          child: Container(height: 1, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _line(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Or continues with',
            style: TextStyle(fontSize: 12, color: AppColors.textLight),
          ),
        ),
        _line(),
      ],
    );
  }
}