import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user/user_provider.dart';

class IsPremium extends StatelessWidget {
  final Widget Function(bool isPremium) builder;

  const IsPremium({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return builder(value.user.premium);
      },
    );
  }
}
