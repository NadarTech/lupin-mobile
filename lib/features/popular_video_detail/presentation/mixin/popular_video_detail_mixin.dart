import 'package:flutter/material.dart';
import 'package:luden/features/popular_video_detail/presentation/view_model/popular_video_detail_view_model.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/provider/user/user_provider.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/enum/event_type.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/mix_panel/mix_panel_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../view/popular_video_detail_view.dart';

mixin PopularVideoDetailMixin on State<PopularVideoDetailView> {
  VideoPlayerController? controller;
  late TextEditingController promptController;
  var completed = false;

  Future<void> generateVideo(bool premium) async {
    await MixpanelService.track(type: EventType.generateVideoButtonTappedAtHome);
    if (promptController.text != '') {
      final user = getIt<UserProvider>().user;
      if (user.coins >= 800) {
        context.read<PopularVideoDetailViewModel>().generateVideo(
          prompt: promptController.text,
          aiModel: 'veo3',
          duration: '8s',
          coins: 800,
        );
        promptController.clear();
      } else {
        if (premium == true) {
          getIt<RouteService>().go(path: AppRoutes.coins);
        } else {
          getIt<RouteService>().go(path: AppRoutes.subscriptions);
        }
      }
    } else {
      toastification.show(
        title: Text('Please enter the prompt', style: AppStyles.regular(fontSize: 15)),
        alignment: Alignment.topCenter,
        backgroundColor: AppColors.red,
        icon: SizedBox(),
        borderSide: BorderSide(width: 0),
        closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    promptController = TextEditingController();
    controller = VideoPlayerController.asset(widget.homeModel.videoPath)..setLooping(true);
    await controller?.initialize();
    await controller?.play();
    setState(() {});
  }

  @override
  void dispose() {
    controller?.dispose();
    promptController.dispose();
    super.dispose();
  }
}
