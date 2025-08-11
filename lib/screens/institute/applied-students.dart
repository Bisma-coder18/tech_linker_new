import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/modules/controllers/institute/applied-students-controller.dart';
import 'package:tech_linker_new/screens/institute/applied-student-detail.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';
import 'package:tech_linker_new/widget/cached_img.dart';

class AppliedUsersScreen extends StatelessWidget {
  AppliedUsersScreen({super.key});
  final AppliedUsersController controller = Get.put(AppliedUsersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body:SafeArea(
        child: Column(
        
          children: [
            Text(
            "Applied Users",
            style: AppTextStyles.darkH4_500.copyWith(fontSize: 20),
          ),
         Obx(() {
          if (controller.isLoading.value) {
            return Align(
              alignment: Alignment.center,
              child: Center(child: CircularProgressIndicator(color: AppColors.primary)));
          }
          if (controller.posts.isEmpty) {
            return Center(
              child: Text(
                "No applications yet",
                style: AppTextStyles.medium16l.copyWith(color: Colors.grey[600]),
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              final post = controller.posts[index];
              final appliedUsers = controller.appliedUsers[post.id] ?? [];
              return _buildPostSection(post.title, appliedUsers);
            },
          );
        }),
            
        
          ],
        ),
      ));
      
  }

  Widget _buildPostSection(String postTitle, List<User> users) {
    return Container(
      // elevation: 4,
      // surfaceTintColor: AppColors.backgroundColor,
      decoration: BoxDecoration(
              color: AppColors.backgroundColor,

          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: AppColors.primary,
            width: 1,
          ),
        ),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              postTitle,
              style: AppTextStyles.darkH4_500.copyWith(
                fontSize: 18,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            if (users.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "No users applied yet",
                  style: AppTextStyles.medium16l.copyWith(color: Colors.grey[600]),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[200],
                          child: CachedImage(imageUrl: user.profileImage.isNotEmpty ? user.profileImage : ''),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: AppTextStyles.mediumBold,
                              ),
                              Text(
                                user.email,
                                style: AppTextStyles.medium14.copyWith(color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.info_outline, color: AppColors.primary, size: 20),
                          onPressed: () {
                            Get.to(()=>InternshipUserDetailScreen(jobId: '1',userId: "1",));
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}