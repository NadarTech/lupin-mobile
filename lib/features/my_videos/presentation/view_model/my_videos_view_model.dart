import 'package:flutter/material.dart';

import '../../../../common/model/video/video_model.dart';
import '../../data/data_source/my_videos_data_source.dart';

class MyVideosViewModel extends ChangeNotifier {
  final MyVideosDataSource _dataSource;

  MyVideosViewModel(this._dataSource);

  final myVideos = <VideoModel>[];

  Future<void> getVideos() async {
    final result = await _dataSource.getVideos();
    result.fold((error) {}, (response) async {
      myVideos.clear();
      myVideos.addAll(response);
      notifyListeners();
    });
  }
}
