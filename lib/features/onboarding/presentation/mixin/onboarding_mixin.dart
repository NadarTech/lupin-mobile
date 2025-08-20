import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/consts/gen/assets.gen.dart';
import '../../data/model/onboarding_model.dart';
import '../view/onboarding_view.dart';
import '../view_model/onboarding_view_model.dart';

mixin OnboardingMixin on State<OnboardingView> {
  late VideoPlayerController controller;
  late VideoPlayerController controller1;
  late VideoPlayerController controller2;
  late OnboardingViewModel provider;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = context.read<OnboardingViewModel>();
    });
    controller = VideoPlayerController.asset(Assets.videos.ob4)
      ..setLooping(true)
      ..initialize().whenComplete(() {
        controller.play();
      });
    controller1 = VideoPlayerController.asset(Assets.videos.paywall)
      ..setLooping(true)
      ..initialize();
    controller2 = VideoPlayerController.asset(Assets.videos.trend3)
      ..setLooping(true)
      ..initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  final onboardings = <OnboardingModel>[
    OnboardingModel(
      title: 'Create Videos in Seconds',
      subtitle:
          'Turn your ideas into stunning videos instantly with AI. Just type your prompt and let the magic happen.',
    ),
    OnboardingModel(
      title: 'Make It Fun & Unexpected',
      subtitle:
          'Whether it’s a donkey dancing or something totally wild, AI helps you generate funny, surprising videos with zero effort.',
    ),
    OnboardingModel(
      title: 'Unleash Your Imagination',
      subtitle: 'From fantasy creatures to dream worlds, create unique videos limited only by your creativity.',
    ),
    OnboardingModel(
      title: 'Please review our app',
      subtitle: 'Your feedback will help us get better for your future convenience',
      image: Assets.images.reviewUs.path,
    ),
  ];

  void changeCurrentIndex() {
    provider.changeCurrentIndex();
    if (provider.currentIndex == 0) {
      controller.play();
      controller1.pause();
      controller2.pause();
    } else if (provider.currentIndex == 1) {
      controller1.play();
      controller.pause();
      controller2.pause();
    } else {
      controller2.play();
      controller.pause();
      controller1.pause();
    }
  }
}
