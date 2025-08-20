import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/consts/app/app_constants.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../../../../core/services/toast/toast_service.dart';
import '../view/subscriptions_view.dart';

mixin SubscriptionsMixin on State<SubscriptionsView> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    controller = VideoPlayerController.asset(Assets.videos.paywall)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().whenComplete(() {
        controller.play();
        setState(() {});
      });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (AppConstants.offer != null) {
        Future.delayed(const Duration(seconds: 1)).then((_) async {
          await RevenueCatUI.presentPaywall(offering: AppConstants.offer);
          final customerInfo = await Purchases.getCustomerInfo();
          if (customerInfo.entitlements.active.isNotEmpty) {
            ToastService.success('You are premium member now 🎉');

            /// TODO: GET USER OR SAVE TO LOCALE
            getIt<RouteService>().goRemoveUntil(path: AppRoutes.home);
          }
        });
      }
    });
  }
}
