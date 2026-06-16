import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class TestLogoutScreenView extends StatelessWidget {
  const TestLogoutScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');
    final hasToken = token != null;

    return Scaffold(
      backgroundColor: const Color(0xffF5F0FF),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F0FF),
        elevation: 0,
        title: Text(
          'Session Debug',
          style: GoogleFonts.balsamiqSans(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Token Status Card ──────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: hasToken
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: hasToken ? Colors.green.shade200 : Colors.red.shade200,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        hasToken ? Icons.check_circle : Icons.cancel,
                        color: hasToken ? Colors.green : Colors.red,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        hasToken ? 'Token Found' : 'No Token Stored',
                        style: GoogleFonts.balsamiqSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: hasToken ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  if (hasToken) ...[
                    const SizedBox(height: 8),
                    Text(
                      // Show only first 40 chars so it fits
                      'Token: ${token.toString().substring(0, 40)}...',
                      style: GoogleFonts.balsamiqSans(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ── Logout Button ──────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () async {
                  try {
                    if (token != null) {
                      await http.post(
                        Uri.parse('http://10.0.2.2:8000/logout'),
                        headers: {
                          'Authorization': 'Bearer $token',
                          'Content-Type': 'application/json',
                        },
                      );
                    }
                  } catch (_) {
                    // Still log out locally even if server unreachable
                  } finally {
                    box.remove('token');
                    Get.offAllNamed(AppRoutes.login);
                  }
                },
                icon: const Icon(Icons.logout),
                label: Text(
                  'Logout',
                  style: GoogleFonts.balsamiqSans(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B0FCC),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // ── Clear token locally only (no server call) ──────────────────
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () {
                  box.remove('token');
                  Get.snackbar('Done', 'Token cleared locally');
                  // Rebuild to refresh token status card
                  Get.off(() => const TestLogoutScreenView());
                },
                icon: const Icon(Icons.delete_outline),
                label: Text(
                  'Clear Token Locally',
                  style: GoogleFonts.balsamiqSans(fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}