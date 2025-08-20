import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../common/provider/user/user_provider.dart';
import '../../../../common/widget/custom_app_bar.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (getIt<UserProvider>().user.premium == false)
              GestureDetector(
                onTap: () {
                  getIt<RouteService>().go(path: AppRoutes.subscriptions);
                },
                child: Container(
                  width: context.width,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 24.h, horizontal: 9.w),
                  padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    image: DecorationImage(image: AssetImage(Assets.images.colorful.path), fit: BoxFit.fill),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
                    child: Text('Go Premium', style: AppStyles.bold(fontSize: 26)),
                  ),
                ),
              ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: AppColors.secondary),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildBox(icon: Assets.icons.identifier, text: 'Copy User ID', iconWidth: 16, onTap: copyUserId),
                  buildDivider(context),
                  buildBox(icon: Assets.icons.aiModels, text: 'My Videos', iconWidth: 16, onTap: goMyVideos),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 9.w),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: AppColors.secondary),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildBox(icon: Assets.icons.heart, text: 'Rate Us', onTap: rateUs),
                  buildDivider(context),
                  buildBox(icon: Assets.icons.send, text: 'Share', iconWidth: 18, onTap: shareUs),
                  buildDivider(context),
                  buildBox(icon: Assets.icons.termsOfUse, text: 'Terms of Use', onTap: goTermsOfUse),
                  buildDivider(context),
                  Consumer<UserProvider>(
                    builder: (BuildContext context, provider, Widget? child) {
                      if (provider.user.premium != true) {
                        return Column(
                          children: [
                            buildBox(icon: Assets.icons.restore, text: 'Restore Purchase', onTap: restorePurchase),
                            buildDivider(context),
                          ],
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                  buildBox(icon: Assets.icons.secure, text: 'Privacy Policy', onTap: goPrivacyPolicy),
                ],
              ),
            ),
          ],
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
        color: AppColors.transparent,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Row(
          children: [
            icon.svg(width: iconWidth?.w ?? 20.w, color: AppColors.white),
            SizedBox(width: 24.w),
            Text(text, style: AppStyles.semiBold(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  CustomAppBar buildAppBar() {
    return CustomAppBar(
      title: 'Settings',
      automaticallyImplyLeading: false,
      centerTitle: true,
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
