import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/modules/controllers/auth/student_auth_controller.dart';
import 'package:tech_linker_new/screens/student/auth/student_forgot_password.dart';
import 'package:tech_linker_new/screens/student/auth/student_signup.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';
import 'package:tech_linker_new/widget/common_fill_btn.dart';
import 'package:tech_linker_new/widget/common_textfeild.dart';

class StudentLoginScreen extends StatelessWidget {
  StudentLoginScreen({super.key});
  final controller = Get.put(StudentSignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white, AppColors.primary.withOpacity(0.8)],
          ),
        ),
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment:Alignment.topLeft ,
                    child: GestureDetector(
                      onTap: ()=>Get.back(),
                      child: Icon(Icons.arrow_back, size: 25, color: AppColors.primary))),

                  // Logo or Icon Placeholder
                  Icon(Icons.lock, size: 80, color: AppColors.primary),
                  const SizedBox(height: 40),
                  // Header
                  Text(
                    'Welcome Back',
                    style: AppTextStyles.bold28.copyWith(color: AppColors.primary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Log in to continue your journey',
                    style: AppTextStyles.medium16l,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white.withOpacity(0.9),
                    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal:  10.0,vertical: 20),
                      child: Form(
                        key: controller.loginKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextField(
                              controller: controller.emailController,
                              label: 'Email',
                              prefixIcon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) => controller.email.value = value,
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Please enter email';
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                  return 'Invalid email format';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            Obx(() => CustomTextField(
                              controller: controller.passwordController,
                              label: 'Password',
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
                              onChanged: (value) => controller.password.value = value,
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Required';
                                if (value.length < 8) return 'Minimum 8 characters';
                                return null;
                              },
                            )),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => Get.to(()=>ForgotPasswordScreen()),
                                child: Text(
                                  'Forgot Password?',
                                  style: AppTextStyles.med14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            
                            CommonFillButton(onPressed: controller.isLoading.value ? null : controller.login, text: 'Log In', isLoading: controller.isLoading)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Sign Up Prompt
                  Center(
                    child: TextButton(
                      onPressed: () => Get.off(()=>StudentSignupScreen()),
                      child: RichText(
                        text: TextSpan(
                          text: 'Don’t have an account? ',
                          style: AppTextStyles.normal14,
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: AppTextStyles.medium14.copyWith(color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
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