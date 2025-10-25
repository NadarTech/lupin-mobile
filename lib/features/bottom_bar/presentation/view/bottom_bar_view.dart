import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luden/features/home/presentation/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../common/widget/custom_upgrade_alert.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../generate_by_fal_ai/presentation/view/generate_by_fal_ai_view.dart';
import '../../../generate_by_fal_ai/presentation/view_model/generate_by_fal_ai_view_model.dart';
import '../../../home/presentation/view/home_view.dart';
import '../../../my_videos/presentation/view/my_videos_view.dart';
import '../../../my_videos/presentation/view_model/my_videos_view_model.dart';
import '../mixin/bottom_bar_mixin.dart';
import '../view_model/bottom_bar_view_model.dart';

class BottomBarView extends StatefulWidget {
  final bool? firstOpen;

  const BottomBarView({super.key, this.firstOpen});

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> with BottomBarMixin {
  @override
  Widget build(BuildContext context) {
    return CustomUpgradeAlert(
      child: Consumer<BottomBarViewModel>(
        builder: (BuildContext context, provider, Widget? child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                IndexedStack(
                  index: provider.currentIndex,
                  children: [
                    ChangeNotifierProvider<HomeViewModel>(
                      create: (BuildContext context) => getIt<HomeViewModel>(),
                      child: HomeView(),
                    ),
                    ChangeNotifierProvider<GenerateByFalAIViewModel>(
                      create: (BuildContext context) => getIt<GenerateByFalAIViewModel>(),
                      child: GenerateByFalAIView(),
                    ),
                    ChangeNotifierProvider<MyVideosViewModel>(
                      create: (BuildContext context) => getIt<MyVideosViewModel>(),
                      child: MyVideosView(),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 30.h),
                    decoration: BoxDecoration(
                      color: AppColors.second.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(36.r),
                            color: AppColors.second.withValues(alpha: 0.75),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () => provider.changeIndex(0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 24.w),
                                  decoration: BoxDecoration(
                                    color: provider.currentIndex == 0 ? AppColors.white.withValues(alpha: 0.3) : null,
                                    borderRadius: BorderRadius.circular(36.r),
                                  ),
                                  child: provider.currentIndex == 0
                                      ? Assets.icons.selectedHome.svg(width: 24.w)
                                      : Assets.icons.home.svg(width: 24.w),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => provider.changeIndex(1),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 24.w),
                                  decoration: BoxDecoration(
                                    color: provider.currentIndex == 1
                                        ? AppColors.white.withValues(alpha: 0.3)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(36.r),
                                  ),
                                  child: provider.currentIndex == 1
                                      ? Assets.icons.selectedPrompt.svg(width: 24.w)
                                      : Assets.icons.prompt.svg(width: 24.w),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => provider.changeIndex(2),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 24.w),
                                  decoration: BoxDecoration(
                                    color: provider.currentIndex == 2 ? AppColors.white.withValues(alpha: 0.3) : null,
                                    borderRadius: BorderRadius.circular(36.r),
                                  ),
                                  child: provider.currentIndex == 2
                                      ? Assets.icons.selectedProfile.svg(width: 24.w)
                                      : Assets.icons.profile.svg(width: 24.w),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
