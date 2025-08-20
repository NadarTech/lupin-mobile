import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/model/trend_video/trend_video_model.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../view/home_view.dart';

mixin HomeMixin on State<HomeView> {
  late VideoPlayerController trend1Controller;
  late VideoPlayerController trend2Controller;
  late VideoPlayerController trend3Controller;
  late VideoPlayerController trend4Controller;
  late VideoPlayerController trend5Controller;
  late VideoPlayerController trend6Controller;
  late VideoPlayerController trend7Controller;
  late VideoPlayerController trend8Controller;
  late VideoPlayerController trend9Controller;
  late VideoPlayerController trend10Controller;
  late List<TrendVideoModel> portraitTrends;
  late List<TrendVideoModel> horizontalTrends;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), FlutterNativeSplash.remove);
    trend1Controller = VideoPlayerController.asset(Assets.videos.trend1)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().whenComplete(() {
        trend1Controller.play();
      });
    trend2Controller = VideoPlayerController.asset(Assets.videos.trend2)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().whenComplete(() {
        trend2Controller.play();
      });
    trend3Controller = VideoPlayerController.asset(Assets.videos.trend3)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().whenComplete(() {
        trend3Controller.play();
      });
    trend4Controller = VideoPlayerController.asset(Assets.videos.trend4)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().whenComplete(() {
        trend4Controller.play();
      });
    trend5Controller = VideoPlayerController.asset(Assets.videos.trend5)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().whenComplete(() {
        trend5Controller.play();
      });
    trend6Controller = VideoPlayerController.asset(Assets.videos.trend6)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().whenComplete(() {
        trend6Controller.play();
      });
    trend7Controller = VideoPlayerController.asset(Assets.videos.trend7)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().whenComplete(() {
        trend7Controller.play();
      });
    trend8Controller = VideoPlayerController.asset(Assets.videos.trend8)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().whenComplete(() {
        trend8Controller.play();
      });
    trend9Controller = VideoPlayerController.asset(Assets.videos.trend9)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().whenComplete(() {
        trend9Controller.play();
      });
    trend10Controller = VideoPlayerController.asset(Assets.videos.trend10)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().whenComplete(() {
        trend10Controller.play();
      });
    portraitTrends = [
      TrendVideoModel(title: 'Shake Dance', controller: trend1Controller, videoName: 'shake-dance', coins: 60),
      TrendVideoModel(title: 'Muscling', controller: trend2Controller, videoName: 'muscling', coins: 50),
      TrendVideoModel(title: 'Mermaid', controller: trend3Controller, videoName: 'fishermen', coins: 50),
      TrendVideoModel(title: 'Body Shake', controller: trend4Controller, videoName: 'body-shake', coins: 50),
      TrendVideoModel(title: 'Child Memory', controller: trend5Controller, videoName: 'child-memory', coins: 50),
      TrendVideoModel(title: 'Nap me', controller: trend6Controller, videoName: 'nap-me', coins: 50),
    ];
    horizontalTrends = [
      TrendVideoModel(title: 'Blow Kiss', controller: trend7Controller, videoName: 'blow-kiss', coins: 50),
      TrendVideoModel(title: 'Rain Kiss', controller: trend8Controller, videoName: 'rain-kiss', coins: 60),
      TrendVideoModel(title: 'Captain America', controller: trend9Controller, videoName: 'captain-america', coins: 60),
      TrendVideoModel(title: 'Cheek Kiss', controller: trend10Controller, videoName: 'cheek-kiss', coins: 50),
    ];
  }

  @override
  void dispose() {
    trend1Controller.dispose();
    trend2Controller.dispose();
    trend3Controller.dispose();
    trend4Controller.dispose();
    trend5Controller.dispose();
    trend6Controller.dispose();
    trend7Controller.dispose();
    trend8Controller.dispose();
    trend9Controller.dispose();
    trend10Controller.dispose();
    super.dispose();
  }
}
