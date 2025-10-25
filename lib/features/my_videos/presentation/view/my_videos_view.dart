import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../common/model/video/video_model.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/enum/event_type.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../../../../core/helper/extension/string.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/mix_panel/mix_panel_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../../../../core/services/toast/toast_service.dart';
import '../mixin/my_videos_mixin.dart';
import '../view_model/my_videos_view_model.dart';

class MyVideosView extends StatefulWidget {
  const MyVideosView({super.key});

  @override
  State<MyVideosView> createState() => _MyVideosViewState();
}

class _MyVideosViewState extends State<MyVideosView> with MyVideosMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Consumer<MyVideosViewModel>(
        builder: (BuildContext context, provider, Widget? child) {
          return ListView.builder(
            itemCount: provider.myVideos.length,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            itemBuilder: (context, index) {
              final video = provider.myVideos[index];
              return GestureDetector(
                onTap: () async {
                  await MixpanelService.track(type: EventType.goVideoDetailTapped);
                  if (video.status == 'completed') {
                    getIt<RouteService>().go(path: AppRoutes.completedVideo, data: {'video': video});
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  margin: EdgeInsets.symmetric(horizontal: 12.w).copyWith(bottom: 16.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: AppColors.grey.withValues(alpha: 0.05),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildVideoPhoto(video),
                      SizedBox(width: 12.w),
                      buildVideoDetail(video),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  ClipRRect buildVideoPhoto(VideoModel video) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: CachedNetworkImage(
        imageUrl:
            video.photo ?? 'https://t3.ftcdn.net/jpg/06/61/22/02/360_F_661220215_Tdflsk3W2x0tRi7KPpY3fVRPdnOvvvBX.jpg',
        width: 60.w,
        height: 60.w,
        fit: BoxFit.cover,
        errorWidget: (_, _, _) {
          return Container(height: 60.w, width: 60.w, color: AppColors.grey);
        },
      ),
    );
  }

  Expanded buildVideoDetail(VideoModel video) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(video.title, style: AppStyles.medium(fontSize: 14)),
              Spacer(),
              Text(DateFormat.yMMMd().format(video.createdAt), style: AppStyles.medium(fontSize: 13)),
            ],
          ),
          SizedBox(height: 12.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Status:', style: AppStyles.regular(fontSize: 11, color: Color(0xff9CA3AF))),
              Text(
                video.status.capitalize(),
                style: AppStyles.medium(fontSize: 14, color: statusColored(video.status.capitalize())),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color statusColored(String status) {
    if (status == 'Completed') {
      return Color(0xff95FF00);
    } else if (status == 'Failed') {
      return Color(0xffFF0000);
    } else {
      return Color(0xff0090FF);
    }
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Assets.images.splashLogo.svg(width: 30),
          SizedBox(width: 10.w),
          Text('My Videos', style: AppStyles.semiBold(fontSize: 16)),
        ],
      ),
      centerTitle: false,
      forceMaterialTransparency: true,
      titleSpacing: 16.w,
      actions: [
        GestureDetector(
          onTap: () {
            ToastService.success('Refreshing', backgroundColor: AppColors.first);
            context.read<MyVideosViewModel>().getVideos();
          },
          child: Container(
            color: AppColors.transparent,
            padding: EdgeInsets.only(right: 16.w),
            child: Assets.icons.restore.svg(width: 20.w, color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
