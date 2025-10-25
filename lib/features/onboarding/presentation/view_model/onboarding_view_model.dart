import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/route/route_service.dart';

class OnboardingViewModel extends ChangeNotifier {
  int currentIndex = 0;

  Future<void> changeCurrentIndex() async {
    if (currentIndex == 2) {
      await InAppReview.instance.requestReview();
      getIt<RouteService>().goRemoveUntil(path: AppRoutes.bottomBar, data: {'firstOpen': true});
    } else {
      currentIndex++;
      notifyListeners();
    }
  }
}
