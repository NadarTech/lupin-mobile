import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/model/ai_model/ai_model.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../view_model/generate_by_fal_ai_view_model.dart';

class AIModelSheet extends StatelessWidget {
  final List<AIModel> aiModels;

  const AIModelSheet({super.key, required this.aiModels});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GenerateByFalAIViewModel>();
    return DefaultTextStyle(
      style: AppStyles.regular(),
      child: Container(
        color: AppColors.secondary,
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: 0,
                    child: Assets.icons.close.svg(width: 24.w, color: AppColors.white),
                  ),
                  Text('Select AI Model', style: AppStyles.medium(fontSize: 22)),
                  GestureDetector(
                    onTap: getIt<RouteService>().pop,
                    child: Assets.icons.close.svg(width: 24.w, color: AppColors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            buildAIModelList(provider),
          ],
        ),
      ),
    );
  }

  Expanded buildAIModelList(GenerateByFalAIViewModel provider) {
    return Expanded(
      child: ListView.builder(
        itemCount: aiModels.length,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 18.w),
        itemBuilder: (context, index) {
          final model = aiModels[index];
          return GestureDetector(
            onTap: () {
              provider.selectModel(index);
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.all(12).copyWith(bottom: 0),
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: AppColors.primary,
                border: Border.all(color: AppColors.white, width: 0.5),
              ),
              child: Column(
                children: [
                  buildVideoPlayer(model),
                  SizedBox(height: 10.h),
                  buildVideoDetail(model),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container buildVideoDetail(AIModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      margin: EdgeInsets.only(bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(model.title, style: AppStyles.semiBold(fontSize: 17)),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Text('${model.coins}  ', style: AppStyles.medium(fontSize: 15)),
                    Assets.icons.coin.image(width: 18.w),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Text('${model.seconds}  ', style: AppStyles.medium(fontSize: 15)),
                    Assets.icons.time.svg(width: 16.w, color: AppColors.white),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            model.description,
            style: AppStyles.semiBold(color: AppColors.white.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }

  Container buildVideoPlayer(AIModel model) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          height: model.videoPlayerController.value.size.height,
          width: model.videoPlayerController.value.size.width,
          child: ClipRRect(borderRadius: BorderRadius.circular(16.r), child: VideoPlayer(model.videoPlayerController)),
        ),
      ),
    );
  }
}
