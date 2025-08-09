import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/screens/student/auth/change_password.dart';

class StudentForgotPswrdController  extends GetxController {
     final forgotkey = GlobalKey<FormState>();
     final email = ''.obs;
     final isLoading = false.obs;
     final password = ''.obs;
     final emailController = TextEditingController();
     final passwordController = TextEditingController();

     void resetPassword(){
          if (forgotkey.currentState?.validate() ?? false) {
            try {
      // TODO: Implement signup API call
      Get.to(()=>ChangePasswordScreen());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
          }
      
     }
}