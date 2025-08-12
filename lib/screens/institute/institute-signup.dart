import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/modules/controllers/auth/institute_signup_controller.dart';
import 'package:tech_linker_new/screens/student/auth/student_login.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';
import 'package:tech_linker_new/widget/common_fill_btn.dart';
import 'package:tech_linker_new/widget/custom-text-feild.dart';

class InstituteSignupScreen extends StatelessWidget {
  InstituteSignupScreen({super.key});
  final controller = Get.put(InstituteSignupController());

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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Back Button in Header
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios,
                              size: 25, color: Colors.white),
                          onPressed: () => Get.back(),
                        ),
                      ],
                    ),
                  ),
                  // Icon Placeholder
                  // Icon(Icons.school, size: 80, color: AppColors.primary),
                  // const SizedBox(height: 32),
                  // Header
                  Text(
                    'Create Institute Account',
                    style: AppTextStyles.largeBold
                        .copyWith(color: AppColors.primary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Sign up to manage your institute and connect with students',
                    style: AppTextStyles.medium16l,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Form Card
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white.withOpacity(0.9),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextField(
                              controller: controller.instituteNameController,
                              label: 'Institute Name',
                              prefixIcon: Icons.business,
                              keyboardType: TextInputType.text,
                              onChanged: (value) =>
                              controller.instituteName.value = value,
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return 'Please enter institute name';
                                if (RegExp(r'[!@#\$%^&*(),.?":{}|<>0-9]').hasMatch(value))
                                  return 'Name should not contain special characters or numbers';
                                value = value.trim();
                                if (value.isEmpty)
                                  return 'Name cannot be just spaces';
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              controller: controller.emailController,
                              label: 'Email',
                              prefixIcon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) => controller.email.value = value,
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return 'Please enter your email';
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value))
                                  return 'Please enter a valid email';
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            Obx(()=> CustomTextField(
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
                              onChanged: (value) =>
                                  controller.password.value = value,
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return 'Please enter a password';
                                if (value.length < 6)
                                  return 'Password must be at least 6 characters';
                                return null;
                              },
                            ),
                            ),
                            
                            const SizedBox(height: 16),
                            CustomTextField(
                              controller: controller.contactController,
                              label: 'Contact Number',
                              prefixIcon: Icons.phone,
                              keyboardType: TextInputType.phone,
                              onChanged: (value) =>
                                  controller.contact.value = value,
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return 'Please enter contact number';
                                // Ensure only numbers and minimum 10 digits
                                if (!RegExp(r'^\d+$').hasMatch(value))
                                  return 'Contact number must contain only numbers';
                                if (value.length < 10)
                                  return 'Contact number must be at least 10 digits';
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              controller: controller.addressController,
                              label: 'Address',
                              prefixIcon: Icons.location_on,
                              keyboardType: TextInputType.text,
                              onChanged: (value) =>
                                  controller.instituteName.value = value,
                              validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'Address is required';
  }

  // Disallow address that is only numbers
  if (RegExp(r'^\d+$').hasMatch(value.trim())) {
    return 'Address cannot be only numbers';
  }

  // Disallow address that is only special characters
  if (RegExp(r'^[!@#\$%^&*(),.?":{}|<>]+$').hasMatch(value.trim())) {
    return 'Address cannot be only special characters';
  }

  return null; // Valid if it has words and can include numbers/special chars
},

                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Button at the bottom
                  CommonFillButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.signUp(
                              onSignup: Future.delayed(
                                  const Duration(seconds: 1)), // Example future
                            ),
                    text: 'Create account',
                    isLoading: controller.isLoading,
                  ),
                  SizedBox(
                    height: 15,
                  ),
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
}
