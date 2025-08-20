import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../common/widget/custom_app_bar.dart';
import '../../../../common/widget/custom_button.dart';
import '../../../../common/widget/custom_input.dart';
import '../../../../common/widget/custom_scroll.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
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
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  CustomButton buildGenerateButton(GenerateByFalAIViewModel provider) {
    return CustomButton(
      title: 'Generate Video',
      icon: Row(
        children: [
          Assets.icons.coin.image(width: 20.w),
          Text(
            '  ${aiModels[provider.currentIndex].coins}',
            style: AppStyles.semiBold(fontSize: 13, color: AppColors.primary),
          ),
        ],
      ),
      onTap: generateVideo,
    );
  }

  CustomButton buildSelectAIModelButton(GenerateByFalAIViewModel provider, BuildContext context) {
    return CustomButton(
      title: aiModels[provider.currentIndex].title,
      icon: Assets.icons.rightArrow.svg(color: AppColors.white, width: 20.w),
      textColor: AppColors.white,
      onTap: () {
        showCupertinoSheet(
          context: context,
          useNestedNavigation: false,
          pageBuilder: (context) {
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
      Text('What would you like to create?', style: AppStyles.bold(fontSize: 16)),
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

  CustomAppBar buildAppBar() => CustomAppBar(title: 'Create Video');

  Expanded buildRatio(GenerateByFalAIViewModel provider, int index, SvgGenImage icon, String text) {
    return Expanded(
      child: GestureDetector(
        onTap: () => provider.changePortrait(index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: provider.portraitIndex == index ? AppColors.white.withOpacity(0.3) : null,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.white, width: provider.portraitIndex == index ? 1 : 0),
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
