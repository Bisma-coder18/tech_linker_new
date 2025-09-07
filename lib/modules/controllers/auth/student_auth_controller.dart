import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/models/api-model.dart';
import 'package:tech_linker_new/models/institute-model.dart';
import 'package:tech_linker_new/models/student.dart';
import 'package:tech_linker_new/screens/Admin_dashboard.dart';
import 'package:tech_linker_new/screens/Institute_Dashboard.dart';
import 'package:tech_linker_new/screens/institute/institute-main.dart';
import 'package:tech_linker_new/screens/institute/institute-signup.dart';
import 'package:tech_linker_new/screens/student/auth/student_signup.dart';
import 'package:tech_linker_new/screens/student/main_tab.dart';
import 'package:tech_linker_new/screens/student/onBoarding/onBoarding.dart';
import 'package:tech_linker_new/services/api.dart';
import 'package:tech_linker_new/services/api_services.dart';
import 'package:tech_linker_new/services/apis/institute/institute-apis.dart';
import 'package:tech_linker_new/services/apis/student/auth.dart';
import 'package:tech_linker_new/services/local-storage.dart';

class StudentSignupController extends GetxController {
  final AuthService authService = AuthService();
  final InstituteApiService instituteService = InstituteApiService();
  final isPasswordVisible = false.obs;
  final email = ''.obs;
  final phone = ''.obs;
  final password = ''.obs;
  final role = ''.obs;
  final name = ''.obs;
  final isLoading = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final loginKey = GlobalKey<FormState>();
  void togglePasswordVisibility() => isPasswordVisible.toggle();
  Future<void> signUp() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        isLoading.value = true;

        final response = await GetConnect().post(
          "${AppKeys.baseUrl}/student/signup",
          {
            "name": nameController.text.trim(),
            "email": emailController.text.trim(),
            "password": passwordController.text.trim(),
            "phone": phoneController.text.trim(),
            "role": role.value, // student / institute etc.
          },
        );

        if (response.body['success'] == true) {
          try {
            clearInputs();
            await LocalStorage.saveUser(User.fromJson(response.body['data']));
          } catch (e) {
            print(e);
          }
          Get.offAll(() => MainTabScreen()); // Navigate to main screen
        } else {
          Get.snackbar(
            'Error',
            response.body['message'] ?? 'Signup failed',
          );
        }
      } catch (e) {
        Get.snackbar('Error', e.toString());
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> login() async {
    if (!(loginKey.currentState?.validate() ?? false)) return;

    try {
      isLoading.value = true;
      final ApiResponse resp;
      if (role.value == "student") {
        resp = await authService.loginService(
          email: emailController.text,
          // role: role.value,
          password: passwordController.text,
        );
      } else if (role.value == "institute") {
        resp = await authService.institueLoginService(
            email: emailController.text, password: passwordController.text);
      } else {
        resp = await instituteService.loginInstitute(
            email: emailController.text, password: passwordController.text);
      }
      if (!resp.success) {
        Get.snackbar(
            'Error', resp.message.isNotEmpty ? resp.message : 'Login failed');
        return;
      }

      final user = resp.data;
      if (user == null) {
        // success flag true but no data -> treat as error
        Get.snackbar('Error', 'Server returned no user data');
        return;
      }
      clearInputs();
      if (role.value == 'student') {
        await LocalStorage.saveUser(User.fromJson(user));
        print("user");
        Get.offAll(() => MainTabScreen());
      } else if (role.value == 'institute') {
        print("login data saved");
        await LocalStorage.saveInstUser(InstituteModel.fromJson(user));

        Get.offAll(() => InstituteMainScreen());
      } else {
        Get.offAll(() => AdminDashboard());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onSignUp() async {
    // Get.snackbar('Error', 'Please fill all fields');
    try {
      // TODO: Implement signup API cal
      if (role.value == "student") {
        Get.off(() => StudentSignupScreen());
      } else {
        Get.off(() => InstituteSignupScreen());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void logout() {
    Get.offAll(() => OnBoardingScreen());
  }

  void clearInputs() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    phoneController.clear();

    email.value = '';
    password.value = '';
    name.value = '';
    phone.value = '';
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    nameFocusNode.dispose();
    phoneController.dispose();
    formKey.currentState?.dispose();
    loginKey.currentState?.dispose();

    super.onClose();
  }
}
