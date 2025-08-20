// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/provider/user/user_provider.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/image_picker/image_picker_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../view/trend_video_detail_view.dart';
import '../view_model/trend_video_detail_view_model.dart';

mixin TrendVideoDetailMixin on State<TrendVideoDetailView> {
  Future<void> useThisTemplate() async {
    final user = getIt<UserProvider>().user;
    if (user.coins >= widget.trendVideo.coins) {
      final image = await ImagePickerService.pickImage();
      if (image != null) {
        context.read<TrendVideoDetailViewModel>().createVideo(widget.trendVideo, image);
      }
    } else {
      if (user.premium == true) {
        getIt<RouteService>().go(path: AppRoutes.coins);
      } else {
        getIt<RouteService>().go(path: AppRoutes.subscriptions);
      }
    }
  }
}
