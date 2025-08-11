import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/modules/controllers/auth/student_auth_controller.dart';
import 'package:tech_linker_new/screens/Institute_Dashboard.dart';

class InstituteSignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final studentRole = Get.find<StudentSignupController>().role;
  final instituteNameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final contactController = TextEditingController();
  var instituteName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var contact = ''.obs;
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() => isPasswordVisible.value = !isPasswordVisible.value;

  Future<void> signUp({required Future<dynamic> onSignup}) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
         
        await onSignup; // Execute the passed future (e.g., API call)
        Get.snackbar('Success', 'Account created successfully');
        Get.off(()=>InstituteDashboard()); // Navigate to login on success
      } catch (e) {
        Get.snackbar('Error', 'Failed to create account');
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    instituteNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    contactController.dispose();
    super.onClose();
  }
}