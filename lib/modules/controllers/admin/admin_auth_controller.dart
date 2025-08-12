// lib/modules/controllers/admin/admin_auth_controller.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_linker_new/screens/admin/admin_dashboard.dart';
import 'package:tech_linker_new/screens/student/onBoarding/onBoarding.dart';
import 'package:tech_linker_new/services/admin/admin_dashboard_apis.dart';

class AdminAuthController extends GetxController {
  // Use Rx types for reactive variables
  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;

  // Controllers and focus nodes
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final loginKey = GlobalKey<FormState>();

  // Toggle password visibility
  void togglePasswordVisibility() => isPasswordVisible.toggle();

  Future<void> login() async {
    if (loginKey.currentState?.validate() ?? false) {
      isLoading.value = true;

      try {
        final response = await AdminApiService.login(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (response['success']) {
          // Navigate to admin dashboard on successful login
          Get.offAll(() => const AdminDashboard());
          Get.snackbar('Success', 'Admin login successful');
        } else {
          Get.snackbar(
            'Login Failed',
            response['message'] ?? 'An error occurred',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Network error: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('admin_email'); // Clear stored email
    await prefs.remove('admin_name'); // Clear stored name if used
    Get.offAll(() => OnBoardingScreen());
    Get.snackbar('Info', 'Admin logged out successfully');
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }
}
