import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../../../common/provider/user/user_provider.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../../data/data_source/generate_by_fal_ai_data_source.dart';
import '../../data/model/generate_by_fal_ai_model.dart';

class GenerateByFalAIViewModel extends ChangeNotifier {
  final GenerateByFalAIDataSource _dataSource;

  GenerateByFalAIViewModel(this._dataSource);

  bool isLoading = false;
  int currentIndex = 0;
  int portraitIndex = 0;

  void changeLoading(bool value) {
    isLoading = value;
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
      getIt<RouteService>().popUntil(path: AppRoutes.home);
    });
  }

  void selectModel(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void changePortrait(int index) {
    portraitIndex = index;
    notifyListeners();
  }
}
