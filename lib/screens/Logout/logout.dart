import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/modules/controllers/auth/student_auth_controller.dart';
import 'package:tech_linker_new/screens/student/auth/student_signup.dart';
import 'package:tech_linker_new/screens/student/main_tab.dart';
import 'package:tech_linker_new/screens/student/onBoarding/onBoarding.dart';
import 'package:tech_linker_new/screens/student/settings/settings.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/widget/common_fill_btn.dart';

import 'ImagePickerBottomSheet.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    StudentSignupController authController=StudentSignupController();
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: const Text(
          'Hired & Rejected Users',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
     
      body: Column(
        children: [
       

        const SizedBox(height: 100),

          // 🔹 Emoji
          const Text(
            "😔",
            style: TextStyle(fontSize: 70),
          ),

          const SizedBox(height: 20),

          // 🔹 Logout Text
          const Text(
            "Log out",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Are you sure you want to leave?",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 40),

          // 🔹 Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // Yes Button (Light Blue)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEFF6FF),
                      foregroundColor:AppColors.primary,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text("No"),
                  ),
                ),
                const SizedBox(height: 12),
                // Cancel Button (Blue)
                SizedBox(
                  width: double.infinity,
                  child: 
                 CommonFillButton(onPressed: (){authController.logout();}, text: "Logout", isLoading: authController.isLoading)
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
