import 'package:flutter/material.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';

class HorizontalCards extends StatelessWidget {
  const HorizontalCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12, 
      runSpacing: 12,
      children: [
        _buildCard('Remote', AppColors.grey_20),
        _buildCard('2 Months', AppColors.grey_20),
        _buildCard('Full time', AppColors.grey_20),
      ],
    );
  }

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
}
