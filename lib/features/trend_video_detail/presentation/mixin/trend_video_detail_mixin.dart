// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/provider/user/user_provider.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/helper/show_offer.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/image_picker/image_picker_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../view/trend_video_detail_view.dart';
import '../view_model/trend_video_detail_view_model.dart';

mixin TrendVideoDetailMixin on State<TrendVideoDetailView> {
  VideoPlayerController? controller;
  var completed = false;

  Future<void> useThisTemplate(bool premium) async {
    final user = getIt<UserProvider>().user;
    if (user.coins >= widget.template.coins) {
      final image = await ImagePickerService.pickImage();
      if (image != null) {
        context.read<TrendVideoDetailViewModel>().createVideo(widget.template, image);
      }
    } else {
      if (premium == true) {
        getIt<RouteService>().go(path: AppRoutes.coins);
      } else {
        getIt<RouteService>().go(path: AppRoutes.subscriptions).then((_) {
          showOffer();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final file = await DefaultCacheManager().getSingleFile(widget.template.videoUrl!);
    controller = VideoPlayerController.file(file)..setLooping(true);
    await controller?.initialize();
    await controller?.play();
    setState(() {});
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
