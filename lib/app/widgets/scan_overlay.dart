// lib/widgets/scan_overlay_widget.dart

import 'package:flutter/material.dart';

class ScanOverlayWidget extends StatelessWidget {
  final double progress;

  const ScanOverlayWidget({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final frameW = size.width * 0.85;
    final frameH = frameW / 1.585; // Standard ID card ratio

    return Stack(
      children: [
        // Dimmed background
        Container(color: Colors.black.withOpacity(0.55)),

        // Card frame guide
        Center(
          child: SizedBox(
            width: frameW,
            height: frameH,
            child: CustomPaint(
              painter: _CardFramePainter(progress: progress),
              child: Container(color: Colors.transparent),
            ),
          ),
        ),

        // Animated scan line while processing
        if (progress > 0 && progress < 1)
          Center(
            child: SizedBox(
              width: frameW,
              height: frameH,
              child: _ScanLine(),
            ),
          ),

        // Instruction text above the frame
        Positioned(
          bottom: (size.height - frameH) / 2 - 68,
          left: 0,
          right: 0,
          child: Column(
            children: [
              const Icon(Icons.credit_card, color: Colors.white70, size: 26),
              const SizedBox(height: 8),
              const Text(
                'Place your Khmer ID card inside the frame',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Keep it flat, well-lit and fully visible',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Corner bracket painter ──────────────────────────────────────────────────
class _CardFramePainter extends CustomPainter {
  final double progress;

  const _CardFramePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final color = progress > 0.9
        ? const Color(0xFF4ADE80)   // green on success
        : const Color(0xFF60A5FA);  // blue while scanning

    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const len = 28.0;

    // Top-left corner
    canvas.drawLine(Offset.zero, const Offset(len, 0), paint);
    canvas.drawLine(Offset.zero, const Offset(0, len), paint);

    // Top-right corner
    canvas.drawLine(Offset(size.width, 0), Offset(size.width - len, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, len), paint);

    // Bottom-left corner
    canvas.drawLine(Offset(0, size.height), Offset(len, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(0, size.height - len), paint);

    // Bottom-right corner
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width - len, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width, size.height - len), paint);
  }

  @override
  bool shouldRepaint(_CardFramePainter old) => old.progress != progress;
}

// ── Animated scan line ────────────────────────────────────────────────────
class _ScanLine extends StatefulWidget {
  const _ScanLine();

  @override
  State<_ScanLine> createState() => _ScanLineState();
}

class _ScanLineState extends State<_ScanLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0, end: 1).animate(
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
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => CustomPaint(
        painter: _ScanLinePainter(position: _anim.value),
      ),
    );
  }
}

class _ScanLinePainter extends CustomPainter {
  final double position;

  const _ScanLinePainter({required this.position});

  @override
  void paint(Canvas canvas, Size size) {
    final y = position * size.height;
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          const Color(0xFF60A5FA).withOpacity(0.8),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, y - 2, size.width, 4))
      ..strokeWidth = 2;
    canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
  }

  @override
  bool shouldRepaint(_ScanLinePainter old) => old.position != position;
}