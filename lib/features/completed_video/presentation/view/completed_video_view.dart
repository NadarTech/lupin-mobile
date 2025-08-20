import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toastification/toastification.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/model/video/video_model.dart';
import '../../../../common/widget/custom_app_bar.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../mixin/completed_video_mixin.dart';

class CompletedVideoView extends StatefulWidget {
  final VideoModel video;

  const CompletedVideoView({super.key, required this.video});

  @override
  State<CompletedVideoView> createState() => _CompletedVideoViewState();
}

class _CompletedVideoViewState extends State<CompletedVideoView> with CompletedVideoMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          child: buildVideo(),
        ),
      ),
    );
  }

  FittedBox buildVideo() {
    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        height: controller.value.size.height,
        width: controller.value.size.width,
        child: ClipRRect(borderRadius: BorderRadius.circular(16.r), child: VideoPlayer(controller)),
      ),
    );
  }

  CustomAppBar buildAppBar() => CustomAppBar(
    title: widget.video.title,
    actions: [
      GestureDetector(
        onTap: () async {
          await GallerySaver.saveVideo(widget.video.video!);
          toastification.show(title: Text('Video Saved Successfully'), autoCloseDuration: const Duration(seconds: 5));
        },
        child: Container(
          color: AppColors.transparent,
          padding: EdgeInsets.only(right: 24.w),
          child: Assets.icons.download.svg(width: 24.w, color: AppColors.white),
        ),
      ),
      GestureDetector(
        onTap: () => SharePlus.instance.share(ShareParams(text: widget.video.video)),
        child: Container(
          color: AppColors.transparent,
          padding: EdgeInsets.only(right: 16.w),
          child: Assets.icons.send.svg(width: 20.w, color: AppColors.white),
        ),
      ),
    ],
  );
}
