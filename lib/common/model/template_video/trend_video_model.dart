import 'package:video_player/video_player.dart';

class TemplateVideoModel {
  final String title;
  final String videoName;
  VideoPlayerController controller;
  final int coins;

  TemplateVideoModel({required this.title, required this.videoName, required this.controller, required this.coins});

  Map<String, dynamic> toJson() => {'title': title, 'video_name': videoName};
}
