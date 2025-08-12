import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/modules/controllers/auth/student_auth_controller.dart';
import 'package:tech_linker_new/screens/Institute_Dashboard.dart';
import 'package:tech_linker_new/screens/institute/institute-main.dart';
import 'package:tech_linker_new/services/apis/institute/institute-apis.dart';
import 'package:tech_linker_new/services/local-storage.dart';

class InstituteSignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  InstituteApiService instituteApiService=InstituteApiService();
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
         
    isLoading.value = true;
    final resp = await instituteApiService.signUpInstitute(
      email: emailController.text,
      password: passwordController.text,
      name: instituteNameController.text,
      contact: contactController.text,
      address: addressController.text

    );
      if(!resp.success){
        Get.snackbar(
        'Error',
        resp.message,
        // snackPosition: SnackPosition.BOTTOM,
        // backgroundColor: Colors.red,
        // colorText: Colors.white,
      );
       return;
      }print(resp.data);
      await LocalStorage.saveInstUser(resp.data!);
      Get.offAll(() => InstituteMainScreen());
      } catch (e) {
        Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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