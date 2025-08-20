// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/model/ai_model/ai_model.dart';
import '../../../../common/provider/user/user_provider.dart';
import '../../../../core/consts/enum/event_type.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/mix_panel/mix_panel_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../view/generate_by_fal_ai_view.dart';
import '../view_model/generate_by_fal_ai_view_model.dart';

mixin GenerateByFalAIMixin on State<GenerateByFalAIView> {
  late TextEditingController promptController;

  late VideoPlayerController veo3Controller;
  late VideoPlayerController veo3FastController;
  late VideoPlayerController veo2Controller;
  late VideoPlayerController kling2Controller;
  late VideoPlayerController hailuoController;
  late VideoPlayerController seedanceController;

  late var aiModels = <AIModel>[];

  @override
  void initState() {
    super.initState();
    promptController = TextEditingController();
    initModels();
  }

  void initModels() {
    veo3Controller = VideoPlayerController.asset(Assets.videos.models.veo3)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().whenComplete(() {
        veo3Controller.play();
      });
    veo3FastController = VideoPlayerController.asset(Assets.videos.models.veo3Fast)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().whenComplete(() {
        veo3FastController.play();
      });
    veo2Controller = VideoPlayerController.asset(Assets.videos.models.veo2)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().whenComplete(() {
        veo2Controller.play();
      });
    kling2Controller = VideoPlayerController.asset(Assets.videos.models.kling21)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().whenComplete(() {
        kling2Controller.play();
      });
    hailuoController = VideoPlayerController.asset(Assets.videos.models.haliou)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().whenComplete(() {
        hailuoController.play();
      });
    seedanceController = VideoPlayerController.asset(Assets.videos.models.seedance)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().whenComplete(() {
        seedanceController.play();
      });
    aiModels = <AIModel>[
      AIModel(
        title: 'Google Veo 3',
        aiName: 'veo3',
        videoPlayerController: veo3Controller,
        seconds: '8s',
        coins: 800,
        description: 'Latest technology generating AI Videos with sound',
      ),
      AIModel(
        title: 'Google Veo 3 Fast',
        aiName: 'veo3/fast',
        videoPlayerController: veo3FastController,
        seconds: '8s',
        coins: 600,
        description: 'Everything Veo 3 has to offer, but faster',
      ),
      AIModel(
        title: 'Google Veo 2',
        aiName: 'veo2',
        videoPlayerController: veo2Controller,
        seconds: '5s',
        coins: 500,
        description: 'AI Video synthesis for ideas in motions',
      ),
      AIModel(
        title: 'Kling 2.1 Master',
        aiName: 'kling-video/v2.1/master/text-to-video',
        videoPlayerController: kling2Controller,
        seconds: '5',
        coins: 350,
        description: 'AI Video mastery for cinematic storytelling',
      ),
      AIModel(
        title: 'Hailuo 02',
        aiName: 'minimax/hailuo-02/standard/text-to-video',
        videoPlayerController: hailuoController,
        seconds: '6',
        coins: 200,
        description: 'Advanced neural style transfer for distinctive videos',
      ),
      AIModel(
        title: 'Seedance',
        aiName: 'bytedance/seedance/v1/pro/text-to-video',
        videoPlayerController: seedanceController,
        seconds: '5',
        coins: 250,
        description: 'AI-driven processors rendering in fluid motion',
      ),
    ];
  }

  @override
  void dispose() {
    promptController.dispose();
    veo3Controller.dispose();
    veo3FastController.dispose();
    veo2Controller.dispose();
    kling2Controller.dispose();
    hailuoController.dispose();
    seedanceController.dispose();
    super.dispose();
  }

  Future<void> generateVideo() async {
    await MixpanelService.track(type: EventType.generateVideoButtonTapped);
    if (promptController.text != '') {
      final user = getIt<UserProvider>().user;
      if (user.coins >= aiModels[context.read<GenerateByFalAIViewModel>().currentIndex].coins) {
        context.read<GenerateByFalAIViewModel>().generateVideo(
          prompt: promptController.text,
          aiModel: aiModels[context.read<GenerateByFalAIViewModel>().currentIndex].aiName,
          duration: aiModels[context.read<GenerateByFalAIViewModel>().currentIndex].seconds,
          coins: aiModels[context.read<GenerateByFalAIViewModel>().currentIndex].coins,
        );
      } else {
        if (user.premium == true) {
          getIt<RouteService>().go(path: AppRoutes.coins);
        } else {
          getIt<RouteService>().go(path: AppRoutes.subscriptions);
        }
      }
    }
  }
}
