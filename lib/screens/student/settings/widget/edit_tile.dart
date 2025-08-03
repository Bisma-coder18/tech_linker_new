import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';

class EditTile extends StatelessWidget {
  final String title;
  final String leftIcon;
  final String iconPath; // Right icon
  final VoidCallback onTap;

  const EditTile({
    required this.title,
    required this.leftIcon,
    required this.iconPath,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.1),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Icon + Text
            Row(
              children: [
                SvgPicture.asset(leftIcon, height: 20, width: 20),
                SizedBox(width: 12),
                Text(title, style: AppTextStyles.medium16Light),
              ],
            ),

            // Right icon
            SvgPicture.asset(iconPath, height: 20, width: 20),
          ],
        ),
      ),
    );
  }
}
