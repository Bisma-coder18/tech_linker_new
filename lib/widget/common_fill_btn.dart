import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';

class CommonFillButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final RxBool isLoading;
  final double? width;
  final double? height;

  const CommonFillButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isLoading,
    this.width,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: width ?? double.infinity,
          height: height,
          child: ElevatedButton(
            onPressed: isLoading.value ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: isLoading.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : Text(
                    text,
                    style: AppTextStyles.medium16.copyWith(color: Colors.white),
                  ),
          ),
        ));
  }
}