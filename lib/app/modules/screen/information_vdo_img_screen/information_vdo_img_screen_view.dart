import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/core/widgets/app_button_eleveted.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

part 'information_vdo_img_screen_binding.dart';
part 'information_vdo_img_screen_controller.dart';

class InformationVdoImgScreenView
    extends GetView<InformationVdoImgScreenViewController> {
  const InformationVdoImgScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Text នៅកណ្តាល
            Center(
              child: Text(
                "Use img picker packer \npackage, let user \nselected img then \nconfirm, and redirect back \nto post screen.",
                textAlign: TextAlign.center,
                style: GoogleFonts.balsamiqSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // Confirm button នៅខាងក្រោមស្តាំ
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: ElevatedButton(
            //       onPressed: () {
            //         // TODO: action
            //       },
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: const Color(0xFF5B2EFF),
            //         foregroundColor: Colors.white,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(30),
            //         ),
            //         padding: const EdgeInsets.symmetric(
            //           horizontal: 40,
            //           vertical: 14,
            //         ),
            //       ),
            //       child: Text(
            //         "Confirm",
            //         style: GoogleFonts.balsamiqSans(fontSize: 16),
            //       ),
            //     ),
            //   ),
            // ),
              Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppButton(
                  title: 'Confirm',
                  onPressed: () {
                    
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
