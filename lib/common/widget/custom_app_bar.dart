import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/consts/color/app_colors.dart';
import '../../core/consts/text_style/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool? centerTitle;
  final bool? automaticallyImplyLeading;
  final int? fontSize;
  final Function()? onTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle,
    this.automaticallyImplyLeading,
    this.fontSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Text(title, style: AppStyles.medium(fontSize: fontSize?.w ?? 23)),
        ),
      ),
      titleSpacing: 2,
      actions: actions,
      forceMaterialTransparency: true,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      iconTheme: IconThemeData(color: AppColors.white),
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 6);
}
