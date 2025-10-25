import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../common/provider/user/user_provider.dart';
import '../../../../common/widget/custom_button.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/enum/event_type.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/mix_panel/mix_panel_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../../../../core/services/toast/toast_service.dart';

class CoinsViewModel extends ChangeNotifier {
  bool isLoading = false;

  void changeLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> onPurchaseStarted(Package package) async {
    if (isLoading == true) return;
    changeLoading(true);
  }

  Future<void> onPurchaseCompleted(_, __) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      await getIt<UserProvider>().getUser();
      buildShowDialog();
    } catch (error) {
      await MixpanelService.track(
        type: EventType.onPurchaseCompletedCatchError,
        args: {'error': error.toString() ?? ''},
      );
      ToastService.warning(error.toString());
    } finally {
      changeLoading(false);
    }
  }

  void buildShowDialog() {
    showCupertinoDialog(
      barrierDismissible: false,
      context: getIt<RouteService>().navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.second,
          title: Column(
            children: [
              SizedBox(height: 20.h),
              Assets.images.check.image(width: 60.w),
              SizedBox(height: 40.h),
              Text('Coins Successfully Updated', style: AppStyles.medium(fontSize: 20),textAlign: TextAlign.center,),
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
                onTap: ()=> getIt<RouteService>().popUntil(path: AppRoutes.bottomBar),
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

  Future<void> onPurchaseError(PurchasesError error) async {
    changeLoading(false);
    await MixpanelService.track(type: EventType.onPurchaseError, args: {'error': error.message ?? ''});
    ToastService.warning(error.message);
  }

  Future<void> onPurchaseCancelled() async {
    await MixpanelService.track(type: EventType.onPurchaseCancelled);
    changeLoading(false);
  }
}
