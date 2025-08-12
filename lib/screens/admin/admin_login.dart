import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/modules/controllers/admin/admin_auth_controller.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';
import 'package:tech_linker_new/widget/common_fill_btn.dart';
import 'package:tech_linker_new/widget/custom-text-feild.dart';

class AdminLoginScreen extends StatelessWidget {
  AdminLoginScreen({super.key});
  final AdminAuthController controller = Get.put(AdminAuthController());

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
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(Icons.arrow_back_ios,
                          size: 25, color: AppColors.primary),
                    ),
                  ),

                  // Admin Icon
                  Icon(Icons.admin_panel_settings,
                      size: 80, color: AppColors.primary),
                  const SizedBox(height: 40),

                  // Header
                  Text(
                    'Admin Portal',
                    style:
                        AppTextStyles.bold28.copyWith(color: AppColors.primary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Access administrative dashboard',
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20),
                      child: Form(
                        key: controller.loginKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextField(
                              controller: controller.emailController,
                              label: 'Admin Email',
                              prefixIcon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) =>
                                  controller.email.value = value,
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return 'Please enter admin email';
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return 'Invalid email format';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            Obx(() => CustomTextField(
                                  controller: controller.passwordController,
                                  label: 'Admin Password',
                                  prefixIcon: Icons.lock,
                                  obscureText:
                                      !controller.isPasswordVisible.value,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey[600],
                                    ),
                                    onPressed:
                                        controller.togglePasswordVisibility,
                                  ),
                                  onChanged: (value) =>
                                      controller.password.value = value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Please enter admin password';
                                    return null;
                                  },
                                )),
                            const SizedBox(height: 30),
                            Obx(() => CommonFillButton(
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : controller.login,
                                  text: 'Access Dashboard',
                                  isLoading: controller.isLoading,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Security Notice
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.security,
                            color: Colors.orange[700], size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Authorized access only. Contact system administrator for credentials.',
                            style: AppTextStyles.normal12
                                .copyWith(color: Colors.orange[700]),
                          ),
                        ),
                      ],
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
