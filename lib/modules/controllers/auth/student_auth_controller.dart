import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class StudentSignupController extends GetxController {
  final isPasswordVisible = false.obs;
  final email = ''.obs;
  final password = ''.obs;
  final name = ''.obs;
  final isLoading = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final loginKey = GlobalKey<FormState>();
  void togglePasswordVisibility() => isPasswordVisible.toggle();

  Future<void> signUp() async {
    if (formKey.currentState?.validate() ?? false) {
      // Get.snackbar('Error', 'Please fill all fields');
    try {
      // TODO: Implement signup API call
      Get.snackbar('Success', 'Account created successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    }

  }  Future<void> login() async {
    if (loginKey.currentState?.validate() ?? false) {
      // Get.snackbar('Error', 'Please fill all fields');
    try {
      // TODO: Implement signup API call
      Get.snackbar('Success', 'Login  successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    }

  }
}