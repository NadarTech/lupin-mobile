import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/provider/category/category_provider.dart';
import '../../../../common/provider/user/user_provider.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/local/app_locals.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../../../../core/services/storage/storage_service.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300)).then((_) async {
      FlutterNativeSplash.remove();
      await checkUser();
    });
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> checkUser() async {
    final routeService = getIt<RouteService>();
    final storageService = getIt<StorageService>();
    await getIt<CategoryProvider>().getCategories();
    await getIt<CategoryProvider>().initTemplateVideos();
    if (await storageService.read(AppLocals.accessToken) != null) {
      await getIt<UserProvider>().getUser();
      await Purchases.logIn(getIt<UserProvider>().user.id.toString());
      await routeService.goRemoveUntil(path: AppRoutes.bottomBar);
    } else {
      final uuid = Uuid().v4();
      await getIt<UserProvider>().createUser(uuid: uuid);
      await getIt<UserProvider>().getUser();
      await Purchases.logIn(getIt<UserProvider>().user.id.toString());
      await routeService.goRemoveUntil(path: AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Spacer(flex: 5), buildLogo(), Spacer(flex: 4), buildLoadingIndicator(), Spacer(flex: 2)],
        ),
      ),
    );
  }

  SizedBox buildLoadingIndicator() {
    return SizedBox(
      width: 250.w,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            width: 250.w,
            height: 10.h,
            decoration: BoxDecoration(color: AppColors.grey, borderRadius: BorderRadius.circular(16.r)),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 250.w * _controller.value,
                  height: 10.h,
                  decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(16.r)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Row buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.images.splashLogo.svg(width: 80.w),
        SizedBox(width: 20.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Luden AI', style: AppStyles.semiBold(fontSize: 24, color: AppColors.grey)),
            SizedBox(height: 3.h),
            Text(
              'AI Video Generator',
              style: AppStyles.regular(fontSize: 16, color: AppColors.grey.withValues(alpha: 0.5)),
            ),
          ],
        ),
      ],
    );
  }
}
