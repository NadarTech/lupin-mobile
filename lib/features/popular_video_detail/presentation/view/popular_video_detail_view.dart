import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luden/features/home/data/home_model.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/widget/custom_back_button.dart';
import '../../../../common/widget/custom_button.dart';
import '../../../../common/widget/custom_input.dart';
import '../../../../common/widget/is_premium.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../mixin/popular_video_detail_mixin.dart';
import '../view_model/popular_video_detail_view_model.dart';

class PopularVideoDetailView extends StatefulWidget {
  final HomeModel homeModel;

  const PopularVideoDetailView({super.key, required this.homeModel});

  @override
  State<PopularVideoDetailView> createState() => _PopularVideoDetailViewState();
}

class _PopularVideoDetailViewState extends State<PopularVideoDetailView> with PopularVideoDetailMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (controller != null && controller!.value.isInitialized)
                FittedBox(
                  fit: BoxFit.cover,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    height: controller?.value.size.height,
                    width: controller?.value.size.width,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
                    child: ClipRRect(borderRadius: BorderRadius.circular(16.r), child: VideoPlayer(controller!)),
                  ),
                ),
              SizedBox(height: 20.h),
              Consumer<PopularVideoDetailViewModel>(
                builder: (BuildContext context, provider, Widget? child) {
                  return Row(
                    children: [
                      buildRatio(provider, 0, Assets.icons.landscape, 'Landscape\n(16:9)'),
                      SizedBox(width: 16.w),
                      buildRatio(provider, 1, Assets.icons.portrait, 'Portrait\n(9:16)'),
                      SizedBox(width: 16.w),
                      buildRatio(provider, 2, Assets.icons.square, 'Square\n(1:1)'),
                    ],
                  );
                },
              ),
              SizedBox(height: 30.h),
              CustomInput(
                hintText: 'Type here a detailed description of what you want to see in your video',
                controller: promptController,
                validator: (_) {
                  return;
                },
                maxLines: 5,
                extraButton: promptController.text == ''
                    ? Positioned(
                        bottom: 10.h,
                        right: 10.w,
                        child: GestureDetector(
                          onTap: () {
                            promptController.text = widget.homeModel.prompt;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Row(
                              children: [
                                Assets.icons.magic.svg(width: 16.w, color: AppColors.first),
                                SizedBox(width: 6.w),
                                Text('Surprise Me', style: AppStyles.medium(color: AppColors.first, fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
              SizedBox(height: 80.h),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom + 10.h),
                child: buildGenerateButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IsPremium buildGenerateButton() {
    return IsPremium(
      builder: (bool isPremium) {
        return CustomButton(
          title: 'Generate',
          icon: isPremium != false
              ? Row(
                  children: [
                    Assets.icons.coin.svg(width: 16.w),
                    SizedBox(width: 3.w),
                    Text('  800', style: AppStyles.semiBold(fontSize: 12)),
                  ],
                )
              : null,
          onTap: () => generateVideo(isPremium),
        );
      },
    );
  }

  AppBar buildAppBar() => AppBar(
    title: Text(widget.homeModel.title, style: AppStyles.medium(fontSize: 16)),
    iconTheme: IconThemeData(color: AppColors.grey),
    centerTitle: false,
    leadingWidth: 66.w,
    leading: CustomBackButton(),
    titleSpacing: 0,
    actions: [
      IsPremium(
        builder: (isPremium) {
          if (isPremium == true) {
            return Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                  margin: EdgeInsets.only(right: 10.w),
                  child: Row(
                    children: [
                      Assets.icons.coin.svg(width: 16.w),
                      SizedBox(width: 5.w),
                      Text('800', style: AppStyles.semiBold(fontSize: 12)),
                    ],
                  ),
                ),
                SizedBox(height: 7.h),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                  margin: EdgeInsets.only(right: 10.w),
                  child: Row(
                    children: [
                      Assets.icons.time.svg(width: 16.w, color: AppColors.white),
                      SizedBox(width: 5.w),
                      Text('8', style: AppStyles.semiBold(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    ],
  );

  Expanded buildRatio(PopularVideoDetailViewModel provider, int index, SvgGenImage icon, String text) {
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
