import 'package:video_player/video_player.dart';

class AIModel {
  final String title;
  final String aiName;
  final VideoPlayerController videoPlayerController;
  final String seconds;
  final int coins;
  final String description;

  AIModel({
    required this.title,
    required this.aiName,
    required this.videoPlayerController,
    required this.seconds,
    required this.coins,
    required this.description,
  });
}
