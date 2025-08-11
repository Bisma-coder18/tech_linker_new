import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/modules/controllers/institute/hired-rejected.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/widget/cached_img.dart';

class HiredRejectedUsersScreen extends StatelessWidget {
  const HiredRejectedUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HiredRejectedUsersController controller = Get.put(HiredRejectedUsersController());

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
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: AppColors.primary));
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hired Users',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              ...controller.hiredUsers.map((user) => _buildUserCard(user, isHired: true)).toList(),
              const SizedBox(height: 24),
              const Text(
                'Rejected Users',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              ...controller.rejectedUsers.map((user) => _buildUserCard(user, isHired: false)).toList(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user, {required bool isHired}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey.shade200,
          child: CachedImage(imageUrl: user['imageUrl'] ?? ''),
        ),
        title: Text(
          user['name'] ?? 'Unknown',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          user['description'] ?? 'No description',
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isHired ? Colors.green.shade100 : Colors.red.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            isHired ? 'Hired' : 'Rejected',
            style: TextStyle(
              fontSize: 12,
              color: isHired ? Colors.green.shade800 : Colors.red.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}