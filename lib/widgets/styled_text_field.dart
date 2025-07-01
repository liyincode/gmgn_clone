// lib/widgets/styled_text_field.dart

import 'package:flutter/material.dart';
import 'package:gmgn_app/theme/app_colors.dart';
import 'package:gmgn_app/theme/app_text_styles.dart';

class StyledTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? suffixText;
  final bool hasBorder;
  final Color? fillColor;
  // **新增**: contentPadding 可选参数
  final EdgeInsets? contentPadding;
    final TextEditingController? controller; // <--- 添加这一行


  const StyledTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixText,
    this.hasBorder = true,
    this.fillColor,
    // **新增**: 在构造函数中接收
    this.contentPadding,
    this.controller, // <--- 添加这一行
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      style: AppTextStyles.listItemTitle,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.listItemSubtitle,
        filled: true,
        fillColor: fillColor ?? AppColors.cardBackground,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffix: suffixText != null
            ? Text(
                suffixText!,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
        border: hasBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: AppColors.border),
              )
            : InputBorder.none,
        enabledBorder: hasBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: AppColors.border),
              )
            : InputBorder.none,
        focusedBorder: hasBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
              )
            : InputBorder.none,
        // **更新**: 使用传入的padding，如果没有则使用默认值
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }
}
