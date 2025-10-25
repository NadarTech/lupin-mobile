import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/model/category/category_model.dart';
import '../../../../common/widget/custom_back_button.dart';
import '../../../../common/widget/custom_button.dart';
import '../../../../common/widget/is_premium.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../mixin/trend_video_detail_mixin.dart';

class TrendVideoDetailView extends StatefulWidget {
  final TemplateModel template;

  const TrendVideoDetailView({super.key, required this.template});

  @override
  State<TrendVideoDetailView> createState() => _TrendVideoDetailViewState();
}

class _TrendVideoDetailViewState extends State<TrendVideoDetailView> with TrendVideoDetailMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (controller != null && controller!.value.isInitialized)
                FittedBox(
                  fit: BoxFit.cover,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 32.w),
                    height: controller?.value.size.height,
                    width: controller?.value.size.width,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
                    child: ClipRRect(borderRadius: BorderRadius.circular(16.r), child: VideoPlayer(controller!)),
                  ),
                ),
              SizedBox(height: 30.h),
              buildUseButton(),
            ],
          ),
        ),
      ),
    );
  }

  IsPremium buildUseButton() {
    return IsPremium(
      builder: (bool isPremium) {
        return CustomButton(title: 'Use this template', onTap: () => useThisTemplate(isPremium));
      },
    );
  }

  AppBar buildAppBar() => AppBar(
    title: Text(widget.template.title, style: AppStyles.medium(fontSize: 16)),
    iconTheme: IconThemeData(color: AppColors.grey),
    centerTitle: false,
    leadingWidth: 66.w,
    leading: CustomBackButton(),
    titleSpacing: 0,
    actions: [
      IsPremium(
        builder: (isPremium) {
          if (isPremium == true) {
            return Container(
              decoration: BoxDecoration(color: AppColors.dark, borderRadius: BorderRadius.circular(8.r)),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              margin: EdgeInsets.only(right: 16.w),
              child: Row(
                children: [
                  Assets.icons.coin.svg(width: 16.w),
                  SizedBox(width: 3.w),
                  Text('  ${widget.template.coins}', style: AppStyles.semiBold(fontSize: 12)),
                ],
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    ],
  );
}
