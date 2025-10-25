import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../common/widget/is_premium.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../../../../core/helper/extension/context.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../mixin/settings_mixin.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with SettingsMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: IsPremium(
          builder: (bool isPremium) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(isPremium != true)...[
                  Text('Premium', style: AppStyles.regular()),
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: () => getIt<RouteService>().go(path: AppRoutes.subscriptions),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
                      decoration: BoxDecoration(
                        color: AppColors.grey.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Assets.icons.premium.svg(width: 30.w),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Upgrade to Premium', style: AppStyles.medium()),
                              SizedBox(height: 2.h),
                              Text(
                                'Unlock all premium features',
                                style: AppStyles.regular(fontSize: 11, color: AppColors.grey.withValues(alpha: 0.7)),
                              ),
                            ],
                          ),
                          Spacer(),
                          Assets.icons.rightArrow.svg(width: 20, color: AppColors.grey),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
                Text('Support and Legal', style: AppStyles.regular()),
                SizedBox(height: 12.h),
                buildBox(
                  icon: Assets.icons.contact,
                  text: 'Contact',
                  onTap: () {
                    launchUrlString('mailto:yusuf.nadaroglu@nadartech.com?subject=Subject&body=Hi%20Team');
                  },
                ),
                buildBox(icon: Assets.icons.rateUs, text: 'Rate Us', onTap: rateUs),
                buildBox(icon: Assets.icons.share, text: 'Share App', onTap: shareUs),
                buildBox(icon: Assets.icons.termsOfUse, text: 'Terms of Use', onTap: goTermsOfUse),
                buildBox(icon: Assets.icons.privacyPolicy, text: 'Privacy Policy', onTap: goPrivacyPolicy),
              ],
            );
          },
        ),
      ),
    );
  }

  Container buildDivider(BuildContext context) => Container(color: AppColors.grey, height: 0.5, width: context.width);

  GestureDetector buildBox({
    required SvgGenImage icon,
    required String text,
    double? iconWidth,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
        decoration: BoxDecoration(
          color: AppColors.grey.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            icon.svg(width: 30.w),
            SizedBox(width: 8.w),
            Text(text, style: AppStyles.medium()),
            Spacer(),
            Assets.icons.rightArrow.svg(width: 20, color: AppColors.grey),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      titleSpacing: 16.w,
      title: Row(
        children: [
          Assets.images.splashLogo.svg(width: 30),
          SizedBox(width: 10.w),
          Text('Luden AI', style: AppStyles.semiBold(fontSize: 16)),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: getIt<RouteService>().pop,
          child: Container(
            color: AppColors.transparent,
            padding: EdgeInsets.only(right: 16.w),
            child: Assets.icons.close.svg(width: 22.w, color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
