import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/config/app_assets.dart';
import 'package:tech_linker_new/models/student.dart';
import 'package:tech_linker_new/modules/controllers/auth/student_auth_controller.dart';
import 'package:tech_linker_new/modules/controllers/student/student-profile-controller.dart';
import 'package:tech_linker_new/screens/Logout/logout.dart';
import 'package:tech_linker_new/screens/institute/hired-rejected.dart';
import 'package:tech_linker_new/screens/institute/institute-profile.dart';
import 'package:tech_linker_new/screens/student/auth/change_password.dart';
import 'package:tech_linker_new/screens/student/settings/profile/profile.dart';
import 'package:tech_linker_new/screens/student/settings/widget/edit_tile.dart';
import 'package:tech_linker_new/services/local-storage.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';
import 'package:tech_linker_new/widget/cached_img.dart';
import 'package:tech_linker_new/widget/space.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      
 
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
        
                Align(
                  alignment: Alignment.center,
                  child: Text(       
                    "Settings",
                    style: AppTextStyles.darkH4_500,),
                ),
                const Space(height: 40,),
                // User Profile Card
                _buildProfileCard(),
        
                const SizedBox(height: 30),
        
                // Settings Section
                _buildSettingsSection(context),
        
                const SizedBox(height: 30),
        
                // Logout Section
                _buildLogoutSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    final PersonalProfileController controller =
        Get.put(PersonalProfileController());
         final StudentSignupController authController =
        Get.put(StudentSignupController());
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: Obx(() {
                return CachedImage(
                  imageUrl: controller.selectedImage.value?.path,
                  size: 60,
                );
              })),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.nameController.text,
                  style: AppTextStyles.medium16.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Obx(
                  ()=> Text(
                    authController.role.value.capitalize!,
                    style: AppTextStyles.medium16.copyWith(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.verified,
            color: Colors.white,
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            "Account Settings",
            style: AppTextStyles.darkH4_500.copyWith(
              fontSize: 18,
              color: Colors.grey[800],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildSettingsTile(
                title: "Personal Profile",
                subtitle: "Update your personal information",
                leftIcon: AppAssetsPath.profile,
                iconPath: AppAssetsPath.edit,
                onTap: () {
                  //  
                  Get.to(()=> PersonalProfileScreen());
                },
                isFirst: true,
              ),
              // _buildDivider(),
              //  _buildDivider(),
              // _buildSettingsTile(
              //   title: "Rejected Users",
              //   subtitle: "All Rejected Users",
              //   leftIcon: AppAssetsPath.profile,
              //   iconPath: AppAssetsPath.edit,
              //   onTap: () => Get.to(() => HiredRejectedUsersScreen()),
              //   isLast: true,
              // ),
              
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: _buildSettingsTile(
        title: "Logout",
        subtitle: "Sign out of your account",
        leftIcon: AppAssetsPath.logout,
        iconPath: AppAssetsPath.icon,
        onTap: () =>  Get.offAll(()=>LogoutScreen()),
        isFirst: true,
        isLast: true,
        isDanger: true,
      ),
    );
  }

  Widget _buildSettingsTile({
    required String title,
    required String subtitle,
    required String leftIcon,
    required String iconPath,
    required VoidCallback onTap,
    bool isFirst = false,
    bool isLast = false,
    bool isDanger = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.vertical(
        top: isFirst ? const Radius.circular(12) : Radius.zero,
        bottom: isLast ? const Radius.circular(12) : Radius.zero,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDanger
                    ? Colors.red.withOpacity(0.1)
                    : AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                leftIcon,
                height: 20,
                width: 20,
                color: isDanger ? Colors.red : AppColors.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.medium16.copyWith(
                      color: isDanger ? Colors.red : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isDanger ? Icons.logout : Icons.arrow_forward_ios,
              color: isDanger ? Colors.red : Colors.grey[400],
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[200],
      thickness: 1,
      height: 1,
      indent: 56,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/logout');
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
