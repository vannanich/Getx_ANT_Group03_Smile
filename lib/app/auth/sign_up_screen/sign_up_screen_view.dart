import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/auth/sign_up_screen/sign_up_screen_controller.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';
import 'package:flutter_application_1/app/core/widgets/auth_animated_scaffold.dart';
import 'package:flutter_application_1/app/core/widgets/auth_form_card.dart';
import 'package:flutter_application_1/app/core/widgets/auth_input_field.dart';
import 'package:flutter_application_1/app/core/widgets/auth_primary_button.dart';
import 'package:flutter_application_1/app/core/widgets/auth_shimmer_divider.dart';

import 'package:get/get.dart';

class SignUpScreenView extends GetView<SignUpScreenController> {
  const SignUpScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthAnimatedScaffold(
      child: AuthFormCard(
        itemCount: 7,
        builder: (context, staggered, pulseAnim, shimmerAnim) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              staggered(0, _buildHeader()),
              const SizedBox(height: 28),

              // Username
              staggered(
                1,
                Obx(() => AuthInputField(
                      controller: controller.usernameController,
                      hint: 'Username',
                      errorText: controller.usernameError.value.isEmpty
                          ? null
                          : controller.usernameError.value,
                    )),
              ),
              const SizedBox(height: 14),

              // Password
              staggered(
                2,
                Obx(() => AuthInputField(
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
                          transitionBuilder: (child, anim) =>
                              ScaleTransition(scale: anim, child: child),
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
                    )),
              ),
              const SizedBox(height: 14),

              // Confirm Password
              staggered(
                3,
                Obx(() => AuthInputField(
                      controller: controller.confirmPasswordController,
                      hint: 'Confirm password',
                      obscureText:
                          !controller.isConfirmPasswordVisible.value,
                      errorText:
                          controller.confirmPasswordError.value.isEmpty
                              ? null
                              : controller.confirmPasswordError.value,
                      suffixIcon: GestureDetector(
                        onTap: controller.toggleConfirmPasswordVisibility,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, anim) =>
                              ScaleTransition(scale: anim, child: child),
                          child: Icon(
                            controller.isConfirmPasswordVisible.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            key: ValueKey(
                                controller.isConfirmPasswordVisible.value),
                            color: AppColors.textLight,
                            size: 20,
                          ),
                        ),
                      ),
                    )),
              ),
              const SizedBox(height: 44),

              staggered(
                4,
                Obx(() => AuthPrimaryButton(
                      label: 'Next',
                      pulseAnim: pulseAnim,
                      isLoading: controller.isLoading.value,
                      onTap: controller.signUp,
                    )),
              ),
              const SizedBox(height: 16),

              // Already have account
              staggered(
                5,
                Center(
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.login),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account?  ',
                            style: TextStyle(
                                fontSize: 13, color: AppColors.textLight),
                          ),
                          TextSpan(
                            text: 'Sign in',
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
              const SizedBox(height: 28),

              // Shimmer divider
              staggered(6, AuthShimmerDivider(shimmerAnim: shimmerAnim)),
              const SizedBox(height: 40),

              _buildGoogleButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Sign ',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.secondary,
                ),
              ),
              TextSpan(
                text: 'Up',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Sign up your account',
          style: TextStyle(fontSize: 13, color: AppColors.textLight),
        ),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return GestureDetector(
      onTap: controller.signUpWithGoogle,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.secondary, width: 1.4),
        ),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/google.png', width: 24, height: 24),
            const SizedBox(width: 10),
            Text(
              'Continue with Google',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}