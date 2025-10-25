import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luden/core/consts/app/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:purchases_ui_flutter/views/paywall_view.dart';

import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../../../../core/helper/extension/context.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../mixin/coins_mixin.dart';
import '../view_model/coins_view_model.dart';

class CoinsView extends StatefulWidget {
  const CoinsView({super.key});

  @override
  State<CoinsView> createState() => _CoinsViewState();
}

class _CoinsViewState extends State<CoinsView> with CoinsMixin {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CoinsViewModel>();
    print("şu geldik ${AppConstants.purchaseOffer}");
    return Stack(
      children: [
        PaywallView(
          offering: AppConstants.purchaseOffer,
          onPurchaseStarted: provider.onPurchaseStarted,
          onPurchaseError: provider.onPurchaseError,
          onPurchaseCompleted: provider.onPurchaseCompleted,
          onPurchaseCancelled: provider.onPurchaseCancelled,
        ),
        Positioned(
          top: 20.h + MediaQuery.of(context).viewPadding.top,
          right: 30.w,
          child: GestureDetector(
            onTap: getIt<RouteService>().pop,
            child: Material(
              borderRadius: BorderRadius.circular(18.w),
              elevation: 2,
              child: CircleAvatar(
                radius: 18.w,
                backgroundColor: AppColors.white,
                child: Assets.icons.cross.svg(width: 20.w),
              ),
            ),
          ),
        ),
        if (provider.isLoading == true)
          Positioned.fill(
            child: Container(
              height: context.height,
              width: context.width,
              color: Colors.white.withValues(alpha: 0.5),
              child: const Center(child: CupertinoActivityIndicator(color: AppColors.black, radius: 15)),
            ),
          ),
      ],
    );
  }

  Text buildField(String text) {
    return Text('• $text', style: AppStyles.medium(fontSize: 14, color: AppColors.grey));
  }
}
