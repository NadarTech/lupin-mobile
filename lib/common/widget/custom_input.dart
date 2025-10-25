import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/consts/color/app_colors.dart';
import '../../core/consts/text_style/app_text_styles.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final int? maxLines;
  final Widget? extraButton;

  const CustomInput({
    super.key,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.suffixIcon,
    this.obscureText,
    this.onChanged,
    this.inputFormatters,
    this.maxLines,
    this.extraButton,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          obscureText: obscureText ?? false,
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          style: AppStyles.regular(fontSize: 14),
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            suffixIconConstraints: BoxConstraints(maxWidth: 44.w),
            contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
            isDense: true,
            hintStyle: AppStyles.regular(fontSize: 14, color: AppColors.lightGrey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.grey.withValues(alpha: 0.05), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.grey.withValues(alpha: 0.05), width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.grey.withValues(alpha: 0.05), width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.grey.withValues(alpha: 0.05), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.grey.withValues(alpha: 0.05), width: 1),
            ),
            filled: true,
            fillColor: Color(0xffF5F6F7).withValues(alpha: 0.05),
          ),
        ),
        ?extraButton,
      ],
    );
  }
}
