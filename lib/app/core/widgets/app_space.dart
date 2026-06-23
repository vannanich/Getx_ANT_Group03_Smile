import 'package:flutter/material.dart';

class AppSpace extends StatelessWidget {
  final double height;

  const AppSpace({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}