import 'package:flutter/material.dart';

import '../../../../core/consts/end_point/app_end_points.dart';
import '../../../../core/consts/enum/http_type_enums.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/network/network_service.dart';
import '../../../../core/services/toast/toast_service.dart';

class HomeViewModel extends ChangeNotifier {
  bool isLoading = false;
  int currentIndex = 0;

  void changeIndex(int index){
    currentIndex = index;
    notifyListeners();
  }

  void changeLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> updateUser() async {
    try {
      await getIt<NetworkService>().call(AppEndpoints.updateUser, mapper: (_) {}, httpTypes: HttpTypes.get);
      ToastService.success('You are premium member now');
    } catch (_) {}
  }

  AlignmentGeometry alignment() {
    switch(currentIndex){
      case 0: return AlignmentDirectional.centerStart;
      case 1: return AlignmentDirectional.center;
      case 2: return AlignmentDirectional.centerEnd;
    }
    return AlignmentDirectional.centerStart;
  }
}
