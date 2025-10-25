import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:luden/common/provider/user/user_provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../../../../core/services/toast/toast_service.dart';
import '../view/settings_view.dart';

mixin SettingsMixin on State<SettingsView> {
  bool isLoading = false;

  void goPrivacyPolicy() => launchUrlString('https://nadartech.com/privacy-policy-luden');

  void goTermsOfUse() => launchUrlString('https://nadartech.com/terms-of-use-luden');

  void shareUs() => SharePlus.instance.share(
    ShareParams(text: 'https://apps.apple.com/us/app/ai-video-generator-luden-ai/id6751180446'),
  );

  Future<void> rateUs() async {
    if (await InAppReview.instance.isAvailable() == true) {
      InAppReview.instance.requestReview();
    }
  }

  Future<void> copyUserId() async {
    FlutterClipboard.copyWithCallback(
      text: getIt<UserProvider>().user.id,
      onSuccess: () {
        ToastService.success('Copied', gravity: ToastGravity.CENTER);
      },
    );
  }


  Future<void> restorePurchase() async {
    try {
      if (isLoading == true) return;
      isLoading = true;
      final customer = await Purchases.restorePurchases();
      await Future.delayed(const Duration(seconds: 3));
      if (customer.entitlements.all['Lupin Subscription']?.isActive == true) {
        getIt<RouteService>().popUntil(path: AppRoutes.bottomBar);
      } else {
        ToastService.warning('You are not a premium member');
      }
    } finally {
      isLoading = false;
    }
  }
}
