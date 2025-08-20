import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/model/trend_video/trend_video_model.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/enum/event_type.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/mix_panel/mix_panel_service.dart';
import '../../../../core/services/route/route_service.dart';

class PortraitTrends extends StatelessWidget {
  final List<TrendVideoModel> portraitTrends;

  const PortraitTrends({super.key, required this.portraitTrends});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 784 / 1172,
        crossAxisSpacing: 24.w,
        mainAxisSpacing: 24.h,
      ),
      itemCount: portraitTrends.length,
      itemBuilder: (context, index) {
        final trendVideo = portraitTrends[index];
        return GestureDetector(
          onTap: () async {
            await MixpanelService.track(type: EventType.trendFilterTapped);
            getIt<RouteService>().go(path: AppRoutes.trendVideoDetail, data: {'trendVideo': trendVideo});
          },
          child: Stack(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(12.r), child: VideoPlayer(trendVideo.controller)),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.r)),
                  ),
                  alignment: Alignment.center,
                  child: Text(trendVideo.title, style: AppStyles.semiBold(color: AppColors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
