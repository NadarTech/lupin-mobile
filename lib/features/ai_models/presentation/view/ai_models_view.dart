import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/model/ai_model/ai_model.dart';
import '../../../../common/widget/custom_app_bar.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../mixin/ai_models_mixin.dart';

class AiModelsView extends StatefulWidget {
  final List<AIModel> aiModels;

  const AiModelsView({super.key, required this.aiModels});

  @override
  State<AiModelsView> createState() => _AiModelsViewState();
}

class _AiModelsViewState extends State<AiModelsView> with AiModelsMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Select AI Model'),
      body: buildAIModelList(),
    );
  }

  ListView buildAIModelList() {
     return ListView.builder(
      itemCount: widget.aiModels.length,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 18.w),
      itemBuilder: (context, index) {
        final model = widget.aiModels[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop(model);
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
                    Assets.icons.coin.svg(width: 18.w),
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
          Text(model.description, style: AppStyles.semiBold(color: AppColors.white.withValues(alpha: 0.7))),
        ],
      ),
    );
  }

  Container buildVideoPlayer(AIModel model) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Image.asset(model.path),
      ),
    );
  }
}
