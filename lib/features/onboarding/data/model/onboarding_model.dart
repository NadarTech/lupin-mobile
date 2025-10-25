import 'package:video_player/video_player.dart';

class OnboardingModel {
  final String title;
  final String subtitle;
  final String video;
  VideoPlayerController? controller;

  OnboardingModel({required this.title, required this.subtitle, required this.video, this.controller});
}
