import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/consts/color/app_colors.dart';
import '../../core/consts/text_style/app_text_styles.dart';
import '../../core/helper/extension/context.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final double? height;
  final double? width;
  final int? fontSize;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Widget? icon;

  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.height,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.borderColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height ?? 56.h,
        width: width ?? context.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: borderColor ?? AppColors.transparent, width: 1.5),
          color: backgroundColor ?? AppColors.white,
        ),
        child: icon == null
            ? Text(
                title,
                style: AppStyles.semiBold(fontSize: fontSize?.w ?? 16, color: textColor ?? AppColors.primary),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox.shrink(),
                    Text(title, style: AppStyles.semiBold(fontSize: 16, color: textColor ?? AppColors.primary)),
                    ?icon,
                  ],
                ),
              ),
      ),
    );
  }
}
