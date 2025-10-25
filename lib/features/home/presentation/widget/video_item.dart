import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../common/model/category/category_model.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../../../../core/helper/extension/context.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/route/route_service.dart';

class TemplateVideoItem extends StatefulWidget {
  final TemplateModel template;

  const TemplateVideoItem({super.key, required this.template});

  @override
  State<TemplateVideoItem> createState() => _TemplateVideoItemState();
}

class _TemplateVideoItemState extends State<TemplateVideoItem> with AutomaticKeepAliveClientMixin {
  VideoPlayerController? _controller;
  bool _isVisible = false;
  bool _isInitializing = false;

  Future<void> _initializeAndPlay() async {
    if (_isInitializing) return;
    _isInitializing = true;

    try {
      final file = await DefaultCacheManager().getSingleFile(widget.template.videoUrl!);
      _controller = VideoPlayerController.file(file, videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
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
    final visible = info.visibleFraction > 0.5;
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
      key: Key(widget.template.title),
      onVisibilityChanged: _onVisibilityChanged,
      child: GestureDetector(
        onTap: () {
          getIt<RouteService>().go(path: AppRoutes.trendVideoDetail, data: {'template': widget.template});
        },
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: AspectRatio(
                  aspectRatio: 720 / 1080,
                  child: _controller != null && _controller!.value.isInitialized
                      ? VideoPlayer(_controller!)
                      : _buildImagePlaceholder(),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                child: Assets.images.videoShadow.image(height: 100.h, width: context.width, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: 10.h,
              left: 24.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.template.title, style: AppStyles.semiBold()),
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
                            widget.template.number.toString(),
                            style: AppStyles.medium(fontSize: 11, color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Image.asset(widget.template.thumbnail!, fit: BoxFit.fill);
  }

  @override
  bool get wantKeepAlive => true;
}
