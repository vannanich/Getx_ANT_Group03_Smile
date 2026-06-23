import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/auth/login_screen/login_screen_controller.dart';
import 'package:flutter_application_1/app/routes/app_routes.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';
import 'package:flutter_application_1/app/core/widgets/auth_animated_scaffold.dart';
import 'package:flutter_application_1/app/core/widgets/auth_form_card.dart';
import 'package:flutter_application_1/app/core/widgets/auth_input_field.dart' show AuthInputField;
import 'package:flutter_application_1/app/core/widgets/auth_primary_button.dart';
import 'package:flutter_application_1/app/core/widgets/auth_shimmer_divider.dart';
import 'package:get/get.dart';

class LoginScreenView extends GetView<LoginScreenController> {
  const LoginScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthAnimatedScaffold(
      child: AuthFormCard(
        itemCount: 6,
        builder: (context, staggered, pulseAnim, shimmerAnim) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              staggered(0, _buildHeader()),
              const SizedBox(height: 28),

              // Email
              staggered(
                1,
                Obx(() => AuthInputField(
                      controller: controller.emailController,
                      hint: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      errorText: controller.emailError.value.isEmpty
                          ? null
                          : controller.emailError.value,
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
              const SizedBox(height: 8),

              // Forget password
              staggered(
                2,
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.emailVer),
                    child: Text(
                      'Forget password?',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 34),

              // Sign In button
              staggered(
                3,
                Obx(() => AuthPrimaryButton(
                      label: 'Sign In',
                      pulseAnim: pulseAnim,
                      isLoading: controller.isLoading.value,
                      onTap: controller.signIn,
                    )),
              ),
              const SizedBox(height: 12),

              // Continue as guest
              staggered(
                4,
                GestureDetector(
                  onTap: controller.continueAsGuest,
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border:
                          Border.all(color: AppColors.secondary, width: 1.6),
                    ),
                    child: Center(
                      child: Text(
                        'Continue as guest',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Don't have account
              staggered(
                4,
                Center(
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.signUp),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account?  ",
                            style: TextStyle(
                                fontSize: 13, color: AppColors.textLight),
                          ),
                          TextSpan(
                            text: 'Sign up',
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
              const SizedBox(height: 24),

              // Shimmer divider
              staggered(5, AuthShimmerDivider(shimmerAnim: shimmerAnim)),
              const SizedBox(height: 20),

              // Google button
              staggered(5, _buildGoogleButton()),
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
                text: 'In',
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
          'Sign In into your existing account',
          style: TextStyle(fontSize: 13, color: AppColors.textLight),
        ),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return GestureDetector(
      onTap: controller.signInWithGoogle,
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