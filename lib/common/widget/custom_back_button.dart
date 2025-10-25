import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/consts/color/app_colors.dart';
import '../../core/consts/gen/assets.gen.dart';
import '../../core/services/get_it/get_it_service.dart';
import '../../core/services/route/route_service.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: getIt<RouteService>().pop,
      child: Container(
        color: AppColors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Assets.icons.pageBack.svg(),
      ),
    );
  }
}
