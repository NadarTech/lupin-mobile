import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:luden/core/consts/text_style/app_text_styles.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toastification/toastification.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/model/video/video_model.dart';
import '../../../../common/widget/custom_back_button.dart';
import '../../../../common/widget/is_premium.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../../../../core/services/toast/toast_service.dart';
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
      appBar: _buildAppBar(),
      body: completed != true
          ? const Center(child: CupertinoActivityIndicator(color: AppColors.white, radius: 15))
          : FittedBox(
              fit: BoxFit.cover,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 32.w),
                height: controller.value.size.height,
                width: controller.value.size.width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
                child: ClipRRect(borderRadius: BorderRadius.circular(16.r), child: VideoPlayer(controller)),
              ),
            ),
    );
  }

  AppBar _buildAppBar() => AppBar(
    title: Text(widget.video.title, style: AppStyles.medium(fontSize: 16)),
    iconTheme: IconThemeData(color: AppColors.grey),
    leading: CustomBackButton(),
    leadingWidth: 66.w,
    centerTitle: false,
    forceMaterialTransparency: true,
    titleSpacing: 0,
    actions: [
      GestureDetector(
        onTap: () => ToastService.warning('Reported'),
        child: Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: Assets.icons.warning.image(width: 26.w),
        ),
      ),
      IsPremium(
        builder: (bool isPremium) {
          return GestureDetector(
            onTap: () async {
              if (isPremium) {
                await GallerySaver.saveVideo(widget.video.video!);
                toastification.show(
                  title: const Text('✅ Video saved successfully!'),
                  autoCloseDuration: const Duration(seconds: 4),
                );
              } else {
                getIt<RouteService>().go(path: AppRoutes.subscriptions);
              }
            },
            child: Container(
              padding: EdgeInsets.only(right: 12.w),
              child: Assets.icons.download.svg(width: 34.w),
            ),
          );
        },
      ),
      IsPremium(
        builder: (bool isPremium) {
          return GestureDetector(
            onTap: () {
              if (isPremium) {
                SharePlus.instance.share(ShareParams(text: widget.video.video));
              } else {
                getIt<RouteService>().go(path: AppRoutes.subscriptions);
              }
            },
            child: Container(
              color: AppColors.transparent,
              padding: EdgeInsets.only(right: 16.w),
              child: Assets.icons.shareVideo.svg(width: 34.w),
            ),
          );
        },
      ),
    ],
  );
}
