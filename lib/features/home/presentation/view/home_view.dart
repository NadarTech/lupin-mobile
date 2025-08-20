import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../common/provider/user/user_provider.dart';
import '../../../../common/widget/custom_app_bar.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/enum/event_type.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../../../../core/helper/extension/context.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/mix_panel/mix_panel_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../mixin/home_mixin.dart';
import '../widget/horizontal_trends.dart';
import '../widget/portrait_trends.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCreateVideoButton(context),
            Text('Trends', style: AppStyles.bold(fontSize: 32)),
            SizedBox(height: 16.h),
            PortraitTrends(portraitTrends: portraitTrends),
            HorizontalTrends(horizontalTrends: horizontalTrends),
          ],
        ),
      ),
    );
  }

  GestureDetector buildCreateVideoButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await MixpanelService.track(type: EventType.createVideoButtonTapped);
        getIt<RouteService>().go(path: AppRoutes.generateByFalAI);
      },
      child: Stack(
        children: [
          Container(
            width: context.width,
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 24.h),
            padding: EdgeInsets.symmetric(vertical: 30.h),
            decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(16.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.icons.play.svg(width: 46.w, color: AppColors.white),
                SizedBox(width: 24.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AI Video', style: AppStyles.semiBold(fontSize: 20)),
                    Text('Create stunning videos', style: AppStyles.medium(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 10.h,
            right: 15.w,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(8.r)),
              child: Text('New', style: AppStyles.bold(color: AppColors.white)),
            ),
          ),
        ],
      ),
    );
  }

  CustomAppBar buildAppBar() {
    return CustomAppBar(
      title: 'Lupin AI',
      automaticallyImplyLeading: false,
      fontSize: 24,
      actions: [
        GestureDetector(
          onTap: () {
            if (getIt<UserProvider>().user.premium == true) {
              getIt<RouteService>().go(path: AppRoutes.coins);
            } else {
              getIt<RouteService>().go(path: AppRoutes.subscriptions);
            }
          },
          child: Container(
            decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(99)),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: EdgeInsets.only(right: 24.w),
            child: Row(
              children: [
                Consumer<UserProvider>(
                  builder: (BuildContext context, provider, Widget? child) {
                    return Text('${provider.user.coins}    ', style: AppStyles.semiBold(fontSize: 13));
                  },
                ),
                Assets.icons.coin.image(width: 22.w),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => getIt<RouteService>().go(path: AppRoutes.myVideos),
          child: Container(
            color: AppColors.transparent,
            padding: EdgeInsets.only(right: 24.w),
            child: Assets.icons.profile.svg(width: 22.w, color: AppColors.white),
          ),
        ),
        GestureDetector(
          onTap: () => getIt<RouteService>().go(path: AppRoutes.settings),
          child: Container(
            color: AppColors.transparent,
            padding: EdgeInsets.only(right: 16.w),
            child: Assets.icons.settings.svg(width: 26.w),
          ),
        ),
      ],
    );
  }
}
