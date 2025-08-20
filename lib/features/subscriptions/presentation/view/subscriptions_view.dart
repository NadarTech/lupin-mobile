import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lupin/core/consts/route/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/widget/custom_button.dart';
import '../../../../core/consts/app/app_constants.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../../../../core/helper/extension/context.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../mixin/subscriptions_mixin.dart';
import '../view_model/subscriptions_view_model.dart';

class SubscriptionsView extends StatefulWidget {
  const SubscriptionsView({super.key});

  @override
  State<SubscriptionsView> createState() => _SubscriptionsViewState();
}

class _SubscriptionsViewState extends State<SubscriptionsView> with SubscriptionsMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionsViewModel>(
      builder: (BuildContext context, provider, Widget? child) {
        return Scaffold(
          body: Stack(
            children: [
              buildVideoPlayer(),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(offset: Offset(0, 9), color: AppColors.primary, spreadRadius: 30, blurRadius: 15),
                      ],
                      color: AppColors.primary,
                    ),
                    child: Column(
                      children: [
                        Text('Unlock all locks with AI', style: AppStyles.semiBold(fontSize: 28)),
                        Container(
                          margin: EdgeInsets.only(bottom: 18.h, top: 12.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildField(provider.currentIndex == 0 ? '1600 credits now' : '200 credits per week'),
                              SizedBox(height: 6.h),
                              buildField('Share and download instantly'),
                            ],
                          ),
                        ),
                        buildPremiumBox(
                          provider: provider,
                          title: 'Yearly plan',
                          index: 0,
                          subWidget: Row(
                            children: [
                              Text(
                                '${AppConstants.subscriptions[0].priceString.substring(0, 1)}${(AppConstants.subscriptions[1].price * 52).toStringAsFixed(0)}  ',
                                style: AppStyles.medium(
                                  decoration: TextDecoration.lineThrough,
                                  color: AppColors.white.withValues(alpha: 0.7),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '${AppConstants.subscriptions[0].priceString} per year',
                                style: AppStyles.medium(color: AppColors.white, fontSize: 14),
                              ),
                            ],
                          ),
                          discount: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(16.r)),
                            child: Text(
                              'SAVE %${calculateSavePercentage(AppConstants.subscriptions[1].price * 52, AppConstants.subscriptions[0].price)}',
                              style: AppStyles.bold(fontSize: 13),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        buildPremiumBox(
                          provider: provider,
                          title: '3-day trial',
                          index: 1,
                          subWidget: Text(
                            'then \$${AppConstants.subscriptions[1].price} per week',
                            style: AppStyles.medium(),
                          ),
                          discount: Text('FREE', style: AppStyles.bold(fontSize: 16)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 24.h),
                          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.w),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: AppColors.white),
                          child: Row(
                            children: [
                              Text('Free Trial Enabled', style: AppStyles.semiBold(color: AppColors.primary)),
                              Spacer(),
                              Switch(
                                value: provider.currentIndex == 0 ? false : true,
                                activeTrackColor: AppColors.red,
                                activeColor: AppColors.white,
                                trackOutlineWidth: MaterialStateProperty.resolveWith<double?>(
                                  (Set<MaterialState> states) => 0,
                                ),
                                trackOutlineColor: MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) => Colors.transparent,
                                ),
                                thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                                  (Set<MaterialState> states) => const Icon(Icons.add, color: AppColors.white),
                                ),
                                inactiveThumbColor: AppColors.white,
                                inactiveTrackColor: AppColors.grey,
                                onChanged: (value) {
                                  provider.changeIndex(value == true ? 1 : 0);
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        CustomButton(
                          title: provider.currentIndex == 1 ? 'Try for Free' : 'Continue',
                          fontSize: 18,
                          onTap: provider.purchase,
                          backgroundColor: AppColors.red,
                          textColor: AppColors.white,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          provider.currentIndex == 1
                              ? 'Start 3-day trial for free now, then automatically renews for ${AppConstants.subscriptions[1].priceString}/week. Cancel anytime.'
                              : 'Renews automatically at ${AppConstants.subscriptions[0].priceString} per year. Cancel anytime.',
                          style: AppStyles.medium(color: AppColors.grey, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20.h + MediaQuery.of(context).viewPadding.top,
                right: 30.w,
                child: GestureDetector(
                  onTap: ()=>getIt<RouteService>().goRemoveUntil(path: AppRoutes.home),
                  child: Material(
                    borderRadius: BorderRadius.circular(18.w),
                    elevation: 2,
                    child: CircleAvatar(
                      radius: 18.w,
                      backgroundColor: AppColors.white,
                      child: Assets.icons.cross.svg(width: 20.w),
                    ),
                  ),
                ),
              ),
              if (provider.isLoading == true)
                Positioned.fill(
                  child: Container(
                    height: context.height,
                    width: context.width,
                    color: Colors.white.withValues(alpha: 0.2),
                    child: Center(child: CupertinoActivityIndicator(color: AppColors.white, radius: 15)),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Positioned buildVideoPlayer() {
    return Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  height: controller.value.size.height,
                  width: controller.value.size.width,
                  child: VideoPlayer(controller),
                ),
              ),
            );
  }

  Row buildField(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(backgroundColor: AppColors.white, radius: 5.r),
        SizedBox(width: 6.w),
        Text(text, textAlign: TextAlign.left, style: AppStyles.medium(fontSize: 14)),
      ],
    );
  }

  GestureDetector buildPremiumBox({
    required SubscriptionsViewModel provider,
    required String title,
    required int index,
    required Widget subWidget,
    required Widget discount,
  }) {
    return GestureDetector(
      onTap: () => provider.changeIndex(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: provider.currentIndex == index ? AppColors.red : AppColors.grey,
            width: provider.currentIndex == index ? 3 : 1,
          ),
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppStyles.bold(fontSize: 15)),
                SizedBox(height: 6.h),
                subWidget,
              ],
            ),
            discount,
          ],
        ),
      ),
    );
  }

  String calculateSavePercentage(double originalPrice, double discountedPrice) {
    return (((originalPrice - discountedPrice) / originalPrice) * 100).floor().toStringAsFixed(0);
  }
}
