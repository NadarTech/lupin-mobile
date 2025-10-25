import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luden/features/home/data/home_model.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/route/route_service.dart';

class PopularVideoItem extends StatefulWidget {
  final HomeModel homeModel;

  const PopularVideoItem({super.key, required this.homeModel});

  @override
  State<PopularVideoItem> createState() => _PopularVideoItemState();
}

class _PopularVideoItemState extends State<PopularVideoItem> with AutomaticKeepAliveClientMixin {
  VideoPlayerController? _controller;
  bool _isVisible = false;
  bool _isInitializing = false;

  Future<void> _initializeAndPlay() async {
    if (_isInitializing) return;
    _isInitializing = true;

    try {
      _controller = VideoPlayerController.asset(widget.homeModel.videoPath, videoPlayerOptions: VideoPlayerOptions())
        ..setVolume(0)
        ..setLooping(true);
      await _controller!.initialize();
      await _controller!.play();
      if (!Platform.isAndroid) {
        await _controller!.seekTo(const Duration(milliseconds: 50));
      }
      setState(() {});
    } catch (e) {
      debugPrint("Video init error: $e");
    } finally {
      _isInitializing = false;
    }
  }

  Future<void> _disposeController() async {
    if (_controller != null) {
      try {
        await _controller!.pause();
        await _controller!.dispose();
      } catch (_) {}
      _controller = null;
      if (mounted) setState(() {});
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    final visible = info.visibleFraction > 0.3;
    if (visible == _isVisible) return;
    _isVisible = visible;

    if (visible) {
      _initializeAndPlay();
    } else {
      _disposeController();
    }
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return VisibilityDetector(
      key: Key(widget.homeModel.videoPath),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: (_controller != null && _controller!.value.isInitialized)
                ? AspectRatio(
                    aspectRatio: _controller!.value.size.width / _controller!.value.size.height,
                    child: VideoPlayer(_controller!),
                  )
                : Container(color: AppColors.dark),
          ),
          Positioned(
            bottom: 10.h,
            left: 24.w,
            right: 24.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.homeModel.title, style: AppStyles.semiBold()),
                    SizedBox(height: 5.h),
                    FittedBox(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26.r),
                          color: AppColors.dark.withValues(alpha: 0.5),
                        ),
                        child: Row(
                          children: [
                            Assets.icons.heart.svg(width: 10.w, color: AppColors.white),
                            SizedBox(width: 4.w),
                            Text(
                              widget.homeModel.number.toString(),
                              style: AppStyles.medium(fontSize: 11, color: AppColors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    getIt<RouteService>().go(path: AppRoutes.popularVideoDetail, data: {'homeModel': widget.homeModel});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(50.r)),
                    child: Text('Try it now!', style: AppStyles.medium(color: AppColors.first)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
