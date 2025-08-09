import 'package:flutter/material.dart';
import 'package:tech_linker_new/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLines;
  final String label;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? errorText;
  final String? helperText;
  final Widget? suffixIcon;
  final bool enabled;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? fillColor;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? labelStyle;
  final TextStyle? errorStyle;
  final TextStyle? helperStyle;
  final String? initialValue;
  final bool autofocus;
  final int? maxLength;
  final bool showCounter;
  final bool readOnly;
  final void Function()? onTap;
  final Color? cursorColor;

  const CustomTextField({
    super.key,
    this.controller,
    this.keyboardType,
    this.maxLines = 1,
    required this.label,
    this.prefixIcon,
    this.prefixIconColor,
    this.obscureText = false,
    this.validator,
    this.errorText,
    this.helperText,
    this.suffixIcon,
    this.enabled = true,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.fillColor,
    this.borderRadius = 12.0,
    this.contentPadding,
    this.labelStyle,
    this.errorStyle,
    this.helperStyle,
    this.initialValue,
    this.autofocus = false,
    this.maxLength,
    this.showCounter = false,
    this.readOnly = false,
    this.onTap,
    this.cursorColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBorderColor = borderColor ?? Colors.grey[400]!;
    final defaultFocusedColor = focusedBorderColor ?? AppColors.primary;
    final defaultErrorColor = errorBorderColor ?? theme.colorScheme.error;
    final defaultFillColor = fillColor ?? Colors.grey[100]!;
    final defaultLabelStyle = labelStyle ?? const TextStyle().copyWith(color: AppColors.primary);
    final defaultCursorColor = cursorColor ?? AppColors.primary;

    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      keyboardType: keyboardType,
      maxLines: maxLines,
      obscureText: obscureText,
      enabled: enabled,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      focusNode: focusNode,
      textInputAction: textInputAction,
      autofocus: autofocus,
      maxLength: maxLength,
      readOnly: readOnly,
      onTap: onTap,
      cursorColor: defaultCursorColor,
      style: const TextStyle(), // Add your AppTextStyles.regular16 here if needed
      decoration: InputDecoration(
        labelText: label,
        labelStyle: defaultLabelStyle,
        floatingLabelStyle: defaultLabelStyle.copyWith(color: AppColors.primary),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: prefixIconColor ?? AppColors.primary,
                size: 20,
              )
            : null,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: defaultBorderColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: defaultBorderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: defaultFocusedColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: defaultErrorColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: defaultErrorColor, width: 2),
        ),
        filled: true,
        fillColor: defaultFillColor,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        errorText: errorText,
        errorStyle: errorStyle ??
            TextStyle(color: theme.colorScheme.error),
        helperText: helperText,
        helperStyle: helperStyle ??
            TextStyle(color: Colors.grey[600]),
        counter: showCounter ? null : const SizedBox.shrink(),
      ),
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}