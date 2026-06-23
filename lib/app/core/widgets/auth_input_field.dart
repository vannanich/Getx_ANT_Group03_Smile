import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';

class AuthInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final String? errorText;

  const AuthInputField({
    super.key,
    required this.controller,
    required this.hint,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.errorText,
  });

  @override
  State<AuthInputField> createState() => _AuthInputFieldState();
}

class _AuthInputFieldState extends State<AuthInputField>
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
                const Color(0xFFF8FAFC),
                const Color(0xFFF5F0FF),
                _borderAnim.value,
              ),
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
            style:
                const TextStyle(fontSize: 14, color: AppColors.textDark),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(
                  fontSize: 14, color: AppColors.textLight),
              suffixIcon: widget.suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 15),
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