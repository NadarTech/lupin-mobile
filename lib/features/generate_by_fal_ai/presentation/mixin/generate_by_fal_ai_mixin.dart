// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:luden/core/consts/color/app_colors.dart';
import 'package:luden/core/consts/text_style/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

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

  late var aiModels = <AIModel>[];

  @override
  void initState() {
    super.initState();
    promptController = TextEditingController();
    initModels();
  }

  void initModels() {
    aiModels = <AIModel>[
      AIModel(
        title: 'Google Veo 3',
        aiName: 'veo3',
        seconds: '8s',
        coins: 800,
        description: 'Latest technology generating AI Videos with sound',
        path: Assets.videos.models.veo3.path,
      ),
      AIModel(
        title: 'Google Veo 3 Fast',
        aiName: 'veo3/fast',
        seconds: '8s',
        coins: 600,
        description: 'Everything Veo 3 has to offer, but faster',
        path: Assets.videos.models.veo3Fast.path,
      ),
      AIModel(
        title: 'Google Veo 2',
        aiName: 'veo2',
        seconds: '5s',
        coins: 500,
        description: 'AI Video synthesis for ideas in motions',
        path: Assets.videos.models.veo2.path,
      ),
      AIModel(
        title: 'Kling 2.1 Master',
        aiName: 'kling-video/v2.1/master/text-to-video',
        seconds: '5',
        coins: 350,
        description: 'AI Video mastery for cinematic storytelling',
        path: Assets.videos.models.kling21.path,
      ),
      AIModel(
        title: 'Hailuo 02',
        aiName: 'minimax/hailuo-02/standard/text-to-video',
        seconds: '6',
        coins: 200,
        description: 'Advanced neural style transfer for distinctive videos',
        path: Assets.videos.models.haliou.path,
      ),
    ];
  }

  @override
  void dispose() {
    promptController.dispose();
    super.dispose();
  }

  Future<void> generateVideo(bool premium) async {
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
        title: Text('Please enter the prompt',style: AppStyles.regular(fontSize: 15),),
        alignment: Alignment.topCenter,
        backgroundColor: AppColors.red,
        icon: SizedBox(),
        borderSide: BorderSide(width: 0),
        closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }
}
