import 'package:purchases_flutter/purchases_flutter.dart';

class AppConstants {
  static const appName = 'Luden AI';
  static const fontFamily = 'Inter';
  static List<StoreProduct> subscriptions = <StoreProduct>[];
  static List<StoreProduct> products = <StoreProduct>[];
  static CustomerInfo? customerInfo;
  static Offering? offer;
  static Offering? purchaseOffer;
}
