import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../view/completed_video_view.dart';

mixin CompletedVideoMixin on State<CompletedVideoView> {
  late VideoPlayerController controller;
  var completed = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.video.video!))
      ..setLooping(true)
      ..setVolume(1)
      ..initialize().whenComplete(() {
        setState(() {
          completed = true;
        });
        controller.play();
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
