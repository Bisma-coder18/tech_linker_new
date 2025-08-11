import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/screens/Institute_Dashboard.dart';
import 'package:tech_linker_new/screens/institute/institute-main.dart';
import 'package:tech_linker_new/screens/institute/institute-signup.dart';
import 'package:tech_linker_new/screens/student/auth/student_signup.dart';
import 'package:tech_linker_new/screens/student/main_tab.dart';
import 'package:tech_linker_new/screens/student/onBoarding/onBoarding.dart';

class StudentSignupController extends GetxController {
  final isPasswordVisible = false.obs;
  final email = ''.obs;
  final password = ''.obs;
  final role = ''.obs;
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
    Get.to(()=>MainTabScreen());
      Get.snackbar('Success', 'Account created successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    }

  }  Future<void> login() async {
    if (loginKey.currentState?.validate() ?? false) {
      // Get.snackbar('Error', 'Please fill all fields');
    try {
      // TODO: Implement signup API cal
      if(role.value=="student"){
      Get.to(()=>MainTabScreen());
      Get.snackbar('Success', 'Login  successfully');
      }else{
        Get.to(()=>InstituteMainScreen());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    }

  }
  Future<void> onSignUp() async {
      // Get.snackbar('Error', 'Please fill all fields');
    try {
      // TODO: Implement signup API cal
      if(role.value=="student"){
      Get.off(()=>StudentSignupScreen());
      }else{
        Get.off(()=>InstituteSignupScreen());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }

  }
  void logout(){
    Get.offAll(()=>OnBoardingScreen());
  }
  @override
void onClose() {
  emailController.dispose();
  passwordController.dispose();
  nameController.dispose();
  emailFocusNode.dispose();
  passwordFocusNode.dispose();
  nameFocusNode.dispose();

  // Clear keys
  // (Not strictly "dispose", but reset so Flutter doesn't think it's reused)
  // Avoids duplicate global key
  formKey.currentState?.dispose();
  loginKey.currentState?.dispose();

  super.onClose();
}

}