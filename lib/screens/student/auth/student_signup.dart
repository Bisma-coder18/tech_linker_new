import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/modules/controllers/auth/student_auth_controller.dart';
import 'package:tech_linker_new/screens/student/auth/student_login.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';
import 'package:tech_linker_new/widget/common_textfeild.dart';
import 'package:tech_linker_new/widget/space.dart';

class StudentSignupScreen extends StatelessWidget {
  StudentSignupScreen({super.key});
  final controller = Get.put(StudentSignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, Colors.white],
          ),
        ),
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Animated Header
                  Hero(
                    tag: 'auth-header',
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create Your Account',
                            style: AppTextStyles.bold28
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Start your journey to find the perfect internship',
                            style: AppTextStyles.medium16l
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Form Card
                  Card(
  elevation: 8,
  color: Colors.white.withOpacity(0.9),
  shadowColor: Colors.grey.withValues(alpha: 0.2),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  child: Form(
    key: controller.formKey,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal:  10.0,vertical: 20),
      child: Column(
        children: [
          CustomTextField(
  controller: controller.nameController, 
  label: 'Name',
  prefixIcon: Icons.person,
  keyboardType: TextInputType.text, 
  onChanged: (value) => controller.name.value = value, 
  validator: (value) {
    if (value == null || value.isEmpty) return null; 
    value = value.trim();
    if (value.isEmpty) return 'Name cannot be just spaces';
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>0-9]').hasMatch(value)) {
      return 'Only alphabets are allowed';
    }
    return null;
  },
  focusNode: controller.nameFocusNode, // Use a separate focus node if needed
),
       Space(height: 20),
          AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    curve: Curves.easeInOut,
    child: Material(
      color: Colors.transparent,
      child: CustomTextField(
            controller: controller.emailController,
            label: 'Email Address',
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => controller.email.value = value,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please enter your email';
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            }, 
            focusNode: controller.emailFocusNode,
      ),
    ),
  ),
          const Space(height: 20),
          // Password Field with validation
                  Obx(() =>
            AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    curve: Curves.easeInOut,
    child: Material(
      color: Colors.transparent,
      child: CustomTextField(
            controller: controller.passwordController,
            label: 'Password',
            prefixIcon: Icons.lock,
suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordVisible.value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.grey[500],
                size: 20,
              ),
              onPressed: controller.togglePasswordVisibility,
            ),        
            obscureText: !controller.isPasswordVisible.value,
            onChanged: (value) => controller.password.value = value,
validator: (value) {
              if (value == null || value.isEmpty) return 'Required';
              if (value.length < 8) return 'Minimum 8 characters';
              return null;
            },            focusNode: controller.passwordFocusNode,
      ),
    ),
  )),

      const Space(height: 24),
          // Sign Up Button
          Obx(() => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: controller.isLoading.value ? null : controller.signUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
              ),
              child: controller.isLoading.value
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text(
                      'Create Account',
                      style: AppTextStyles.medium16.copyWith(
                        color: Colors.white,
                      ),
                    ),
            ),
          )),
        ],
      ),
    ),
  ),
),const SizedBox(height: 32),
                  // Divider with OR
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: Colors.grey[300], thickness: 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: AppTextStyles.normalLight,
                        ),
                      ),
                      Expanded(
                        child: Divider(color: Colors.grey[300], thickness: 1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Social Login Buttons
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     _buildSocialButton(
                  //       icon: 'assets/icons/google.png',
                  //       onPressed: controller.signInWithGoogle,
                  //     ),
                  //     const SizedBox(width: 16),
                  //     _buildSocialButton(
                  //       icon: 'assets/icons/linkedin.png',
                  //       onPressed: controller.signInWithLinkedIn,
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 32),
                  // Already have an account
                  Center(
                    child: TextButton(
                     onPressed: () => Get.off(() => StudentLoginScreen()),
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: AppTextStyles.normalLight,
                          children: [
                            TextSpan(
                              text: 'Sign In',
                              style: AppTextStyles.medium14.copyWith(
                                color: AppColors.primary,
                              ),
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

 
  Widget _buildSocialButton({
    required String icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(icon, width: 28, height: 28),
        ),
      ),
    );
  }
}