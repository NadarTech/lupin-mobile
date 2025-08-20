import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/model/trend_video/trend_video_model.dart';
import '../../../../common/widget/custom_app_bar.dart';
import '../../../../common/widget/custom_button.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../mixin/trend_video_detail_mixin.dart';

class TrendVideoDetailView extends StatefulWidget {
  final TrendVideoModel trendVideo;

  const TrendVideoDetailView({super.key, required this.trendVideo});

  @override
  State<TrendVideoDetailView> createState() => _TrendVideoDetailViewState();
}

class _TrendVideoDetailViewState extends State<TrendVideoDetailView> with TrendVideoDetailMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildVideoPlayer(),
            SizedBox(height: 30.h),
            buildUseButton(),
          ],
        ),
      ),
    );
  }

  CustomButton buildUseButton() {
    return CustomButton(
      title: 'Use this template',
      icon: Row(
        children: [
          Assets.icons.coin.image(width: 20.w),
          Text('  ${widget.trendVideo.coins}', style: AppStyles.semiBold(fontSize: 13, color: AppColors.primary)),
        ],
      ),
      onTap: useThisTemplate,
    );
  }

  FittedBox buildVideoPlayer() {
    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        height: widget.trendVideo.controller.value.size.height,
        width: widget.trendVideo.controller.value.size.width,
        child: ClipRRect(borderRadius: BorderRadius.circular(16.r), child: VideoPlayer(widget.trendVideo.controller)),
      ),
    );
  }

  CustomAppBar buildAppBar() => CustomAppBar(title: widget.trendVideo.title, fontSize: 22);
}
