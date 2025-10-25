import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luden/common/widget/is_premium.dart';
import 'package:provider/provider.dart';

import '../../../../common/provider/user/user_provider.dart';
import '../../../../common/widget/custom_button.dart';
import '../../../../common/widget/custom_input.dart';
import '../../../../common/widget/custom_scroll.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../mixin/generate_by_fal_ai_mixin.dart';
import '../view_model/generate_by_fal_ai_view_model.dart';
import '../widget/ai_model_sheet.dart';

class GenerateByFalAIView extends StatefulWidget {
  const GenerateByFalAIView({super.key});

  @override
  State<GenerateByFalAIView> createState() => _GenerateByFalAIViewState();
}

class _GenerateByFalAIViewState extends State<GenerateByFalAIView> with GenerateByFalAIMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<GenerateByFalAIViewModel>(
      builder: (BuildContext context, provider, Widget? child) {
        return Scaffold(
          appBar: buildAppBar(),
          body: SafeArea(
            child: CustomScroll(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...buildPromptInput(),
                    SizedBox(height: 20.h),
                    buildSelectAIModelButton(provider, context),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        buildRatio(provider, 0, Assets.icons.landscape, 'Landscape\n(16:9)'),
                        SizedBox(width: 16.w),
                        buildRatio(provider, 1, Assets.icons.portrait, 'Portrait\n(9:16)'),
                        SizedBox(width: 16.w),
                        buildRatio(provider, 2, Assets.icons.square, 'Square\n(1:1)'),
                      ],
                    ),
                    Spacer(),
                    SizedBox(height: 20.h),
                    buildGenerateButton(provider),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  IsPremium buildGenerateButton(GenerateByFalAIViewModel provider) {
    return IsPremium(
      builder: (bool isPremium) {
        return CustomButton(
          title: 'Generate',
          icon2: Assets.icons.magic.svg(width: 18.w),
          icon: isPremium != false
              ? Row(
                  children: [
                    Assets.icons.coin.svg(width: 16.w),
                    SizedBox(width: 3.w),
                    Text('  ${aiModels[provider.currentIndex].coins}', style: AppStyles.semiBold(fontSize: 12)),
                  ],
                )
              : null,
          onTap: () => generateVideo(isPremium),
        );
      },
    );
  }

  CustomButton buildSelectAIModelButton(GenerateByFalAIViewModel provider, BuildContext context) {
    return CustomButton(
      title: aiModels[provider.currentIndex].title,
      icon: Assets.icons.rightArrow.svg(color: AppColors.white, width: 20.w),
      textColor: AppColors.white,
      fontSize: 14,
      onTap: () async {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return ChangeNotifierProvider.value(
              value: provider,
              child: AIModelSheet(aiModels: aiModels),
            );
          },
        );
      },
      backgroundColor: AppColors.red,
    );
  }

  List<Widget> buildPromptInput() {
    return [
      Text('What amazing video would you like to create today?', style: AppStyles.medium(fontSize: 16)),
      SizedBox(height: 16.h),
      CustomInput(
        hintText: 'Type a prompt, like: ‘a cinematic space battle above Earth’',
        controller: promptController,
        validator: (_) {
          return;
        },
        maxLines: 5,
      ),
    ];
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: false,
      titleSpacing: 16.w,
      forceMaterialTransparency: true,
      title: Row(
        children: [
          Assets.images.splashLogo.svg(width: 30),
          SizedBox(width: 10.w),
          Text('Create Video', style: AppStyles.semiBold(fontSize: 16)),
        ],
      ),
      actions: [
        IsPremium(
          builder: (bool isPremium) {
            return GestureDetector(
              onTap: () {
                if (isPremium == true) {
                  getIt<RouteService>().go(path: AppRoutes.coins);
                } else {
                  getIt<RouteService>().go(path: AppRoutes.subscriptions);
                }
              },
              child: Container(
                decoration: BoxDecoration(color: AppColors.dark, borderRadius: BorderRadius.circular(8.r)),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                margin: EdgeInsets.only(right: 10.w),
                child: Row(
                  children: [
                    Assets.icons.coin.svg(width: 16.w),
                    SizedBox(width: 5.w),
                    Consumer<UserProvider>(
                      builder: (BuildContext context, provider, Widget? child) {
                        return Text('${provider.user.coins}', style: AppStyles.semiBold(fontSize: 12));
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        GestureDetector(
          onTap: () => getIt<RouteService>().go(path: AppRoutes.settings),
          child: Container(
            decoration: BoxDecoration(color: AppColors.dark, borderRadius: BorderRadius.circular(8.r)),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
            margin: EdgeInsets.only(right: 16.w),
            child: Assets.icons.settings.svg(width: 16.w),
          ),
        ),
      ],
    );
  }

  Expanded buildRatio(GenerateByFalAIViewModel provider, int index, SvgGenImage icon, String text) {
    return Expanded(
      child: GestureDetector(
        onTap: () => provider.changePortrait(index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: provider.portraitIndex == index
                ? AppColors.grey.withValues(alpha: 0.15)
                : AppColors.grey.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: provider.portraitIndex == index
                  ? AppColors.grey.withValues(alpha: 0.25)
                  : AppColors.grey.withValues(alpha: 0.05),
              width: provider.portraitIndex == index ? 1 : 0,
            ),
          ),
          child: Column(
            children: [
              icon.svg(width: 24.w, color: AppColors.white),
              SizedBox(height: 10.h),
              Text(text, style: AppStyles.medium(fontSize: 12), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
