import 'package:flutter/material.dart';

import '../app/app_constants.dart';
import '../color/app_colors.dart';
import '../text_style/app_text_styles.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    fontFamily: AppConstants.fontFamily,
    scaffoldBackgroundColor: AppColors.primary,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: AppColors.primary,
      titleTextStyle: AppStyles.medium(color: AppColors.white, fontSize: 30),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: AppConstants.fontFamily,
    scaffoldBackgroundColor: AppColors.primary,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: AppColors.primary,
      titleTextStyle: AppStyles.medium(color: AppColors.white, fontSize: 30),
    ),
  );
}
