import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var newPassword = ''.obs;
  var confirmPassword = ''.obs;
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() => isPasswordVisible.value = !isPasswordVisible.value;

  Future<void> saveChanges({required Future<dynamic> onReset}) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        await onReset; // Execute the passed future (e.g., API call)
        Get.snackbar('Success', 'Password updated successfully');
        Get.offNamed('/login');
      } catch (e) {
        Get.snackbar('Error', 'Failed to update password');
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}