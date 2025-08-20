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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          obscureText: obscureText ?? false,
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          style: AppStyles.semiBold(fontSize: 16),
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            suffixIconConstraints: BoxConstraints(maxWidth: 44.w),
            contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
            isDense: true,
            hintStyle: AppStyles.regular(fontSize: 16, color: AppColors.lightGray),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.lightGray, width: 0.3),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.lightGray, width: 0.3),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.lightGray, width: 0.3),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.lightGray, width: 0.3),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.lightGray, width: 0.3),
            ),
            filled: true,
            fillColor: AppColors.secondary,
          ),
        ),
      ],
    );
  }
}
