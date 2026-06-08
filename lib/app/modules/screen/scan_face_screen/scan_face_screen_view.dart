import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

part 'scan_face_screen_binding.dart';
part 'scan_face_screen_controller.dart';

class ScanFaceScreenView extends GetView<ScanFaceScreenViewController> {
  const ScanFaceScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEECF5),
      appBar: AppBar(
        backgroundColor: Color(0xFFEEECF5),
        toolbarHeight: 70,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Scan face",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            SizedBox(height: 4),
            Text("Review your mood",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF9F9DA4))),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 40),
            _buildTitle(),
            SizedBox(height: 50),
            _buildScanFace(),
            SizedBox(height: 50),
            _buildStartButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Column(
        children: [
          Text("Smile Check 😊",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text("Please smile to for your day",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF9F9DA4))),
        ],
      ),
    );
  }

  Widget _buildScanFace() {
    return Obx(() {
      return SizedBox(
        height: 300,
        width: 280,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Camera preview
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: controller.isCameraReady.value &&
                        controller.cameraController != null
                    ? CameraPreview(controller.cameraController!)
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Icon(Icons.face, size: 80, color: Colors.grey),
                        ),
                      ),
              ),
            ),

            // Corner brackets
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomPaint(
                painter: ScanCornerPainter(),
              ),
            ),

            // Animated scan line
            if (controller.isScanning.value)
              Obx(() => Positioned(
                    top: controller.scanLinePosition.value,
                    left: 20,
                    right: 20,
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Color(0xFF5B3EFF).withValues(alpha: 0.8),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  )),
          ],
        ),
      );
    });
  }

  Widget _buildStartButton() {
    return Obx(() => SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed:
                controller.isScanning.value ? null : controller.startScan,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF5B3EFF),
              disabledBackgroundColor: Color(0xFF5B3EFF).withValues(alpha: 0.6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            child: Text(
              controller.isScanning.value ? "Scanning..." : "Start Scan",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ));
  }
}

class ScanCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF3D3D3D)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    double len = 35;
    double r = 18;

    final double w = size.width;
    final double h = size.height;

    // Top-left 
    canvas.drawPath(
      Path()
        ..moveTo(0, len)
        ..lineTo(0, r)
        ..arcToPoint(
          Offset(r, 0),
          radius: Radius.circular(r),
          clockwise: true,
        )
        ..lineTo(len, 0),
      paint,
    );

    // Top-right 
    canvas.drawPath(
      Path()
        ..moveTo(w - len, 0)
        ..lineTo(w - r, 0)
        ..arcToPoint(
          Offset(w, r),
          radius: Radius.circular(r),
          clockwise: true, // changed from false to true
        )
        ..lineTo(w, len),
      paint,
    );

// Bottom-right 
    canvas.drawPath(
      Path()
        ..moveTo(w - len, h)
        ..lineTo(w - r, h)
        ..arcToPoint(
          Offset(w, h - r),
          radius: Radius.circular(r),
          clockwise: false, // changed from true to false
        )
        ..lineTo(w, h - len),
      paint,
    );

    // Bottom-left 
    canvas.drawPath(
      Path()
        ..moveTo(0, h - len)
        ..lineTo(0, h - r)
        ..arcToPoint(
          Offset(r, h),
          radius: Radius.circular(r),
          clockwise: false,
        )
        ..lineTo(len, h),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
