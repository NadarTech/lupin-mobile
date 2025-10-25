import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../../common/provider/user/user_provider.dart';
import '../../common/widget/custom_button.dart';
import '../consts/app/app_constants.dart';
import '../consts/color/app_colors.dart';
import '../consts/gen/assets.gen.dart';
import '../consts/text_style/app_text_styles.dart';
import '../services/get_it/get_it_service.dart';
import '../services/route/route_service.dart';

void showOffer(){
  if (AppConstants.offer != null && getIt<UserProvider>().user.premium != true) {
    Future.delayed(const Duration(seconds: 1)).then((_) async {
      await RevenueCatUI.presentPaywall(offering: AppConstants.offer);
      final customerInfo = await Purchases.getCustomerInfo();
      if (customerInfo.entitlements.active.containsKey('Lupin Subscription')) {
        await Future.delayed(const Duration(seconds: 3));
        await getIt<UserProvider>().getUser();
        _buildShowDialog();
      }
    });
  }
}


void _buildShowDialog() {
  showCupertinoDialog(
    barrierDismissible: false,
    context: getIt<RouteService>().navigatorKey.currentContext!,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.secondary,
        title: Column(
          children: [
            SizedBox(height: 20.h),
            Assets.images.check.image(width: 60.w),
            SizedBox(height: 40.h),
            Text('Successful Subscription', style: AppStyles.semiBold(fontSize: 20)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Text(
                'Your payment has been received successfully. You can start using the app.',
                style: AppStyles.regular(fontSize: 14,color: AppColors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8.h),
            CustomButton(
              title: 'Thanks',
              onTap: getIt<RouteService>().pop,
              backgroundColor: AppColors.red,
              textColor: AppColors.white,
            ),
            SizedBox(height: 8.h),
          ],
        ),
      );
    },
  );
}
