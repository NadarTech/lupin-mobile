import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/widget/custom_button.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../mixin/onboarding_mixin.dart';
import '../view_model/onboarding_view_model.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> with OnboardingMixin {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingViewModel>();
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(children: [buildVideo(provider), buildBottomInfo(context, provider)]),
      ),
    );
  }

  Positioned buildBottomInfo(BuildContext context, OnboardingViewModel provider) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom, top: 24.h),
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xff10172B), AppColors.second])),
        child: Column(
          children: [
            Text(
              onboardings[provider.currentIndex].title,
              style: AppStyles.semiBold(fontSize: 30, color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.h, bottom: 36.h),
              child: Text(
                onboardings[provider.currentIndex].subtitle,
                style: AppStyles.light(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Stack(
              children: [
                Container(
                  width: 100.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColors.grey.withValues(alpha: 0.1),
                  ),
                ),
                Container(
                  width: ((100 / 3) * (provider.currentIndex + 1)).w,
                  height: 4.h,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: AppColors.grey),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 12.h).copyWith(top: 24.h),
              child: CustomButton(title: 'Next', onTap: changeCurrentIndex),
            ),
          ],
        ),
      ),
    );
  }

  Positioned buildVideo(OnboardingViewModel provider) {
    return Positioned(
      top: 0.h,
      right: 0,
      left: 0,
      child: SizedBox(
        height: 600.h,
        child: VideoPlayer(onboardings[provider.currentIndex].controller!),
      ),
    );
  }

  Column textContent(Widget child, currentIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          child: Text(onboardings[currentIndex].title, style: AppStyles.semiBold(fontSize: 26)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            onboardings[currentIndex].subtitle,
            style: AppStyles.regular(fontSize: 16, color: AppColors.grey),
          ),
        ),
        SizedBox(height: 30.h),
      ],
    );
  }

  AnimatedContainer buildAnimatedDivider(OnboardingViewModel provider) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return Container(
            margin: EdgeInsets.only(right: 12.w),
            width: index == provider.currentIndex ? 20.w : 10.w,
            height: 10.h,
            decoration: BoxDecoration(
              color: index == provider.currentIndex ? AppColors.white : Colors.grey,
              borderRadius: BorderRadius.circular(16.r),
            ),
          );
        }),
      ),
    );
  }

  Text buildSubTitle(OnboardingViewModel provider) {
    return Text(
      onboardings[provider.currentIndex].subtitle,
      style: AppStyles.regular(fontSize: 16, color: Colors.grey),
      textAlign: TextAlign.center,
    );
  }

  Padding buildTitle(OnboardingViewModel provider) {
    return Padding(
      padding: EdgeInsets.only(top: 40.h, bottom: 16.h),
      child: Text(
        onboardings[provider.currentIndex].title,
        style: AppStyles.medium(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
