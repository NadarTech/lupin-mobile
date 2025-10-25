import 'package:flutter/material.dart';
import 'package:luden/core/consts/route/app_routes.dart';
import 'package:luden/core/services/route/route_service.dart';
import 'package:toastification/toastification.dart';

import '../../../../common/provider/user/user_provider.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../bottom_bar/presentation/view_model/bottom_bar_view_model.dart';
import '../../../generate_by_fal_ai/data/model/generate_by_fal_ai_model.dart';
import '../../data/data_source/popular_video_detail_data_source.dart';

class PopularVideoDetailViewModel extends ChangeNotifier {
  final PopularVideoDetailDataSource _dataSource;

  PopularVideoDetailViewModel(this._dataSource);

  bool isLoading = false;
  int portraitIndex = 0;

  void changeLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void changePortrait(int index) {
    portraitIndex = index;
    notifyListeners();
  }

  Future<void> generateVideo({
    required String prompt,
    required String aiModel,
    required int coins,
    required String duration,
  }) async {
    if (isLoading == true) return;
    changeLoading(true);
    final addPromptModel = GenerateByFalAIModel(
      prompt: prompt,
      aspectRatio: ['16:9', '9:16', '1:1'][portraitIndex],
      duration: duration,
      aiModel: aiModel,
      coins: coins,
    );
    final result = await _dataSource.generateVideoByFalAI(addPromptModel: addPromptModel);
    result.fold((error) => changeLoading(false), (response) async {
      changeLoading(false);
      getIt<UserProvider>().updateCoins(coins);
      toastification.show(
        title: Text('Your video will be ready in 1 minutes'),
        autoCloseDuration: const Duration(seconds: 5),
      );
      getIt<RouteService>().popUntil(path: AppRoutes.bottomBar);
      getIt<BottomBarViewModel>().changeIndex(2);
    });
  }
}
