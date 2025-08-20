import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/widget/custom_button.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../../../../core/helper/extension/context.dart';
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
        child: SizedBox(
          height: context.height,
          width: context.width,
          child: Stack(
            children: [
              if (provider.currentIndex == 0)
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: AspectRatio(aspectRatio: 748 / 1172, child: VideoPlayer(controller)),
                )
              else if (provider.currentIndex == 1)
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: AspectRatio(aspectRatio: 784 / 1176, child: VideoPlayer(controller1)),
                )
              else if (provider.currentIndex == 2)
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: AspectRatio(aspectRatio: 748 / 1172, child: VideoPlayer(controller2)),
                )
              else
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: AspectRatio(
                    aspectRatio: 1024 / 1536,
                    child: Image.asset(onboardings[provider.currentIndex].image!),
                  ),
                ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(offset: Offset(0, 9), color: AppColors.primary, spreadRadius: 60, blurRadius: 40),
                    ],
                    color: AppColors.primary,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Text(onboardings[provider.currentIndex].title, style: AppStyles.semiBold(fontSize: 26)),
                      ),
                      Text(
                        onboardings[provider.currentIndex].subtitle,
                        style: AppStyles.regular(fontSize: 16, color: AppColors.grey),
                      ),
                      SizedBox(height: 30.h),
                      if (provider.currentIndex != 3) buildAnimatedDivider(provider),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        child: CustomButton(title: 'Continue', onTap: changeCurrentIndex),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
