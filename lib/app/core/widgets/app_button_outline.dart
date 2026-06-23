import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';

class AppButtonOutline extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData? icon;

  const AppButtonOutline({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(width: 2, color: AppColors.secondary),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.secondary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 20),
              Icon(icon, color: Colors.white),
            ],
          ],
        ),
      ),
    );
  }
}
