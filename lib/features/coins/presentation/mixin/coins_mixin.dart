import 'package:flutter/material.dart';

import '../view/coins_view.dart';

mixin CoinsMixin on State<CoinsView> {
  final coins = [
    {'coins': 100, 'price': '\$3.99'},
    {'coins': 200, 'price': '\$6.99'},
    {'coins': 300, 'price': '\$9.99'},
    {'coins': 400, 'price': '\$12.99'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }
}
