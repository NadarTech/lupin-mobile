import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../common/provider/user/user_provider.dart';
import '../../../../common/widget/custom_button.dart';
import '../../../../core/consts/app/app_constants.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/enum/event_type.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/mix_panel/mix_panel_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../../../../core/services/toast/toast_service.dart';

class SubscriptionsViewModel extends ChangeNotifier {
  bool isLoading = false;
  int currentIndex = 0;

  void changeLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Future<void> purchase() async {
    try {
      if (isLoading == true) return;
      changeLoading(true);
      await MixpanelService.track(
        type: EventType.onPurchaseStarted,
        args: {'identifier': AppConstants.subscriptions[currentIndex].identifier},
      );
      var product = AppConstants.subscriptions[currentIndex];
      await Purchases.purchaseStoreProduct(product);
      await Future.delayed(const Duration(seconds: 3));
      await getIt<UserProvider>().getUser();
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
                  onTap: ()=> getIt<RouteService>().popUntil(path: AppRoutes.home),
                  backgroundColor: AppColors.red,
                  textColor: AppColors.white,
                ),
                SizedBox(height: 8.h),
              ],
            ),
          );
        },
      );
    } on PlatformException catch (error) {
      if ((error).message != 'Purchase was cancelled.') {
        ToastService.warning(error.message);
      }
    } catch (_) {
    } finally {
      changeLoading(false);
    }
  }

  Future<void> onPurchaseStarted(Package package) async {
    if (isLoading == true) return;
    changeLoading(true);
    await MixpanelService.track(type: EventType.onPurchaseStarted, args: {'identifier': package.identifier});
  }

  Future<void> onPurchaseCompleted(_, __) async {
    try {
      ToastService.success('You are premium member now 🎉');
      await MixpanelService.track(type: EventType.onPurchaseCompleted);
      await Future.delayed(const Duration(seconds: 3));
      await getIt<UserProvider>().getUser();
      changeLoading(false);
      await getIt<RouteService>().goRemoveUntil(path: AppRoutes.home);
    } catch (error) {
      await MixpanelService.track(
        type: EventType.onPurchaseCompletedCatchError,
        args: {'error': error.toString() ?? ''},
      );
      ToastService.warning(error.toString());
      changeLoading(false);
    }
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

  Future<void> onRestoreCompleted(CustomerInfo customer) async {
    try {
      if (customer.entitlements.all['x Subscription']?.isActive == true) {
        await MixpanelService.track(type: EventType.onRestoreCompleted);

        /// TODO: GET USER OR SAVE TO LOCALE
        ToastService.success('You are premium member now 🎉');
        getIt<RouteService>().goRemoveUntil(path: AppRoutes.home);
      } else {
        ToastService.warning('You are not a premium member');
      }
    } catch (error) {
      await MixpanelService.track(
        type: EventType.onRestoreCompletedCatchError,
        args: {'error': error.toString() ?? ''},
      );
      ToastService.warning(error.toString());
    }
  }

  Future<void> onRestoreError(PurchasesError error) async {
    await MixpanelService.track(type: EventType.onRestoreError, args: {'error': error.message ?? ''});
  }
}
