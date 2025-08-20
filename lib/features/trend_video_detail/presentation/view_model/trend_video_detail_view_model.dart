import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../../../common/model/trend_video/trend_video_model.dart';
import '../../../../common/provider/user/user_provider.dart';
import '../../../../core/consts/enum/event_type.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/mix_panel/mix_panel_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../../data/data_source/trend_video_detail_data_source.dart';

class TrendVideoDetailViewModel extends ChangeNotifier {
  final TrendVideoDetailDataSource _dataSource;

  TrendVideoDetailViewModel(this._dataSource);

  bool isLoading = false;

  void changeLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> createVideo(TrendVideoModel videoModel, File image) async {
    MixpanelService.track(type: EventType.useThisTemplate, args: {'videoName': videoModel.videoName});
    final formData = FormData();
    formData.fields.add(MapEntry('title', videoModel.title));
    formData.fields.add(MapEntry('coins', videoModel.coins.toString()));
    formData.fields.add(MapEntry('videoName', videoModel.videoName));
    formData.files.add(MapEntry('photo', MultipartFile.fromFileSync(image.path)));
    final result = await _dataSource.createVideo(formData: formData);
    result.fold((error) => changeLoading(false), (response) async {
      getIt<UserProvider>().updateCoins(videoModel.coins);
      toastification.show(
        title: Text('Your video will be ready in 1 minutes'),
        autoCloseDuration: const Duration(seconds: 5),
      );
      getIt<RouteService>().popUntil(path: AppRoutes.home);
    });
  }
}
