import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/modules/controllers/auth/change_password_controller.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';
import 'package:tech_linker_new/widget/common_fill_btn.dart';
import 'package:tech_linker_new/widget/custom-text-feild.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary.withOpacity(0.7), Colors.white],
          ),
        ),
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Shrink-wrap the column
                children: [
                  // Back Button in Header
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () => Get.back(),
                        ),
                        Text(
                          "Change Password",
                          style: AppTextStyles.largeBold.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // Icon Placeholder
                  Icon(Icons.lock, size: 80, color: AppColors.primary),
                  const SizedBox(height: 32),
                  // Header
                  // Text(
                  //   'Change Password',
                  //   style: AppTextStyles.bold28.copyWith(color: AppColors.primary),
                  //   textAlign: TextAlign.center,
                  // ),
                  const SizedBox(height: 16),
                  Text(
                    'Update your password to secure your account',
                    style: AppTextStyles.medium16l,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  // Form Card
                  Flexible(
                    fit: FlexFit.loose, // Allow the card to size to its content
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.white.withOpacity(0.9),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: controller.pformKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // Shrink-wrap the form content
                            children: [
                              CustomTextField(
                                controller: controller.newPasswordController,
                                label: 'New Password',
                                prefixIcon: Icons.lock,
                                obscureText: !controller.isPasswordVisible.value,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isPasswordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey[600],
                                  ),
                                  onPressed: controller.togglePasswordVisibility,
                                ),
                                onChanged: (value) => controller.newPassword.value = value,
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Please enter a new password';
                                  if (value.length < 6) return 'Password must be at least 6 characters';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                controller: controller.confirmPasswordController,
                                label: 'Confirm New Password',
                                prefixIcon: Icons.lock,
                                obscureText: !controller.isPasswordVisible.value,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isPasswordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey[600],
                                  ),
                                  onPressed: controller.togglePasswordVisibility,
                                ),
                                onChanged: (value) => controller.confirmPassword.value = value,
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Please confirm your password';
                                  if (value != controller.newPasswordController.text)
                                    return 'Passwords do not match';
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Button at the bottom
                   CommonFillButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () => controller.saveChanges(
                                onReset: Future.delayed(const Duration(seconds: 1)), // Example future
                              ),
                      text: 'Save Changes',
                      isLoading: controller.isLoading,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}