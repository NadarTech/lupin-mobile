import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../common/provider/user/user_provider.dart';
import '../../../main.dart';
import '../../consts/app/app_constants.dart';
import '../../consts/enum/event_type.dart';
import '../../services/get_it/get_it_service.dart';
import '../../services/local/local_service.dart';
import '../../services/mix_panel/mix_panel_service.dart';
import 'env.dart';

class HelperInit {
  static Future<void> init() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    setupLocator();
    await initPurchase();
    await Future.wait([
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
      MixpanelService.init(),
      getSubscriptions(),
      getOfferings(),
      getIt<LocalService>().init(),
    ]);
  }

  static Future<void> initPurchase() async {
    await Purchases.setLogLevel(LogLevel.error);
    if (Platform.isIOS) {
      await Purchases.configure(PurchasesConfiguration(Env.iosPurchaseId));
    } else {
      await Purchases.configure(PurchasesConfiguration(Env.androidPurchaseId));
    }
    AppConstants.customerInfo = await Purchases.getCustomerInfo();
  }

  static Future<void> getOfferings() async {
    try {
      final offerings = await Purchases.getOfferings();

      Offering? myOffer = offerings.all["lupin_yearly_subscription"];
      if (myOffer != null) {
        if (myOffer.availablePackages.isNotEmpty) {
          if (myOffer.availablePackages.first.storeProduct.introductoryPrice != null) {
            AppConstants.offer = myOffer;
          }
        }
      }
    } catch (error) {
      MixpanelService.track(type: EventType.getOfferingsError, args: {'error': error.toString()});
    }
  }

  static Future<void> getSubscriptions() async {
    try {
      final idsInOrder = ['lupin_yearly_subscription', 'lupin_weekly_subscription'];
      final products = await Purchases.getProducts(idsInOrder, productCategory: ProductCategory.subscription);
      if (Platform.isIOS) {
        products.sort((a, b) => idsInOrder.indexOf(a.identifier).compareTo(idsInOrder.indexOf(b.identifier)));
      } else {
        products.sort(
          (a, b) => idsInOrder
              .indexOf(a.subscriptionOptions![0].productId)
              .compareTo(idsInOrder.indexOf(b.subscriptionOptions![0].productId)),
        );
      }
      AppConstants.subscriptions.addAll(products);
    } catch (error) {
      MixpanelService.track(type: EventType.getSubscriptionsError, args: {'error': error.toString()});
    }
  }

  static Future<void> getProducts() async {
    try {
      final idsInOrder = ['lupin_100_coins', 'lupin_500_coins', 'lupin_1000_coins', 'lupin_3000_coins'];
      final products = await Purchases.getProducts(idsInOrder, productCategory: ProductCategory.nonSubscription);
      if (Platform.isIOS) {
        products.sort((a, b) => idsInOrder.indexOf(a.identifier).compareTo(idsInOrder.indexOf(b.identifier)));
      } else {
        products.sort(
          (a, b) => idsInOrder
              .indexOf(a.subscriptionOptions![0].productId)
              .compareTo(idsInOrder.indexOf(b.subscriptionOptions![0].productId)),
        );
      }
      AppConstants.products.addAll(products);
    } catch (error) {
      MixpanelService.track(type: EventType.getSubscriptionsError, args: {'error': error.toString()});
    }
  }

  static void startApp() {
    runApp(
      MultiProvider(
        providers: [ChangeNotifierProvider<UserProvider>(create: (context) => getIt<UserProvider>())],
        child: const MyApp(),
      ),
    );
  }
}
