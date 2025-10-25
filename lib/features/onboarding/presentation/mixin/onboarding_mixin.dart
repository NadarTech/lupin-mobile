import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/consts/gen/assets.gen.dart';
import '../../data/model/onboarding_model.dart';
import '../view/onboarding_view.dart';
import '../view_model/onboarding_view_model.dart';

mixin OnboardingMixin on State<OnboardingView> {
  late VideoPlayerController videoPlayer1;
  late VideoPlayerController videoPlayer2;
  late VideoPlayerController videoPlayer3;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
    videoPlayer1 = VideoPlayerController.asset(Assets.videos.ob.ob1)
      ..setLooping(true)
      ..initialize().whenComplete(() {
        videoPlayer1.play();
      });
    videoPlayer2 = VideoPlayerController.asset(Assets.videos.ob.ob2)
      ..setLooping(true)
      ..initialize();
    videoPlayer3 = VideoPlayerController.asset(Assets.videos.ob.ob3)
      ..setLooping(true)
      ..initialize();
    onboardings[0].controller = videoPlayer1;
    onboardings[1].controller = videoPlayer2;
    onboardings[2].controller = videoPlayer3;
  }

  @override
  void dispose() {
    videoPlayer1.dispose();
    videoPlayer2.dispose();
    videoPlayer3.dispose();
    onboardings[0].controller?.dispose();
    onboardings[1].controller?.dispose();
    onboardings[2].controller?.dispose();
    super.dispose();
  }

  final onboardings = <OnboardingModel>[
    OnboardingModel(
      title: 'Bring Your\nIdeas to Life',
      subtitle: 'Turn text into stunning\nvideos—no editing needed.',
      video: Assets.videos.ob.ob1,
    ),
    OnboardingModel(
      title: 'Make Funny\nVideos with Animals',
      subtitle: 'Create heart-melting videos\nwith just your voice.',
      video: Assets.videos.ob.ob2,
    ),
    OnboardingModel(
      title: 'Unleash Your\nInner Power',
      subtitle: 'Walk with tiger, rule the frame—\nno CGI, just AI.',
      video: Assets.videos.ob.ob3,
    ),
  ];

  void changeCurrentIndex() {
    final provider = context.read<OnboardingViewModel>();

    provider.changeCurrentIndex();
    if (provider.currentIndex == 1) {
      videoPlayer2.play();
      videoPlayer1.pause();
      videoPlayer3.pause();
    } else {
      videoPlayer3.play();
      videoPlayer2.pause();
      videoPlayer1.pause();
    }
  }
}
