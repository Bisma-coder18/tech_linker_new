import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';

class EmptyWidget extends StatelessWidget {
  final String? svgAsset;
  final IconData? icon;
  final String title;
  final String description;

  const EmptyWidget({
    Key? key,
    this.svgAsset,
    this.icon,
    required this.title,
    required this.description,
  }) : assert(svgAsset != null || icon != null, 'Provide either svgAsset or icon.'),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (svgAsset != null)
            SvgPicture.asset(
              svgAsset!,
            )
          else if (icon != null)
            Icon(
              icon,
              size: 80,
              color: Colors.grey.shade400,
            ),
          const SizedBox(height: 20),
          Text(
            title,
            style: AppTextStyles.subheading16,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: AppTextStyles.med14,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
