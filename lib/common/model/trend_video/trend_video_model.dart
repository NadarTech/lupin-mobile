import 'package:video_player/video_player.dart';

class TrendVideoModel {
  final String title;
  final String videoName;
  VideoPlayerController controller;
  final int coins;

  TrendVideoModel({required this.title, required this.videoName, required this.controller, required this.coins});

  Map<String, dynamic> toJson() => {'title': title, 'video_name': videoName};
}
