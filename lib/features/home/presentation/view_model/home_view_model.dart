import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  bool isLoading = false;

  void changeLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
