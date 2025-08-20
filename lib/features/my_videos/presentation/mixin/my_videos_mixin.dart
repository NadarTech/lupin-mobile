import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view/my_videos_view.dart';
import '../view_model/my_videos_view_model.dart';

mixin MyVideosMixin on State<MyVideosView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyVideosViewModel>().getVideos();
    });
  }
}
