import 'package:flutter/material.dart';

import '../../../../core/consts/enum/event_type.dart';
import '../../../../core/services/mix_panel/mix_panel_service.dart';

class BottomBarViewModel extends ChangeNotifier {
  bool isLoading = false;
  int currentIndex = 0;

  void changeIndex(int index) {
    MixpanelService.track(type: EventType.changeIndex, args: {'index': index});
    currentIndex = index;
    notifyListeners();
  }
}
