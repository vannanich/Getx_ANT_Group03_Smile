import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData? icon;

  const AppButton({
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
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
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
