import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tech_linker_new/models/internship_model.dart';
import 'package:tech_linker_new/screens/student/home/widgets/horizontal_cards.dart';
import 'package:tech_linker_new/screens/student/interships/intership_detail.dart';
import 'package:tech_linker_new/services/api.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';
import 'package:tech_linker_new/widget/cached_img.dart';
import 'package:tech_linker_new/widget/space.dart';

class InternshipCard extends StatelessWidget {
  final Internship job;
  final VoidCallback? onDetail;
  final VoidCallback? onApplyTap;
  final bool buttonVisible;
  const InternshipCard({
    super.key,
    required this.job,
    this.buttonVisible=true,
    this.onDetail,
    this.onApplyTap,
  });

  Widget _buildCard(String title, Color color) {
    return Container(
      padding:EdgeInsets.symmetric(horizontal: 8,vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(title, style: AppTextStyles.normal12),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    print(AppKeys.baseUrl+ job.image,);
    return GestureDetector(
      onTap: onDetail,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: AppColors.primary,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                CachedImage(
                  size: 40,
                  isCircular:false,
                  imageUrl:"${AppKeys.admin}"+job.image,
                ),
                const Space(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: AppTextStyles.mediumBold,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        job.location??"",
                        style: AppTextStyles.normalLight,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const Space(height: 20),
            
            // Tags Row
            Row(
              children: [
               Wrap(
      spacing: 12, 
      runSpacing: 12,
      children: [
        _buildCard(job.jobtype, AppColors.grey_20),
        // _buildCard(job., AppColors.grey_20),
      ],
    )
              ],
            ),
            const Space(height: 10),
            // Footer Row
           Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Text(
        job.stipend??"Free",
        style: AppTextStyles.bold,
      ),
      // Text(
      //   job.timeAgo,
      //   style: AppTextStyles.normal12,
      // ),
      buttonVisible == true
          ? GestureDetector(
              onTap: onApplyTap,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: const Text(
                  'View',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          : const SizedBox.shrink(),
        ],
      ),
      ],
        ),
      ),
    );
  }
}