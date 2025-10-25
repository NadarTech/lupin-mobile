// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../common/provider/user/user_provider.dart';
import '../../../../common/widget/custom_button.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/enum/event_type.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/mix_panel/mix_panel_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../view/bottom_bar_view.dart';

mixin BottomBarMixin on State<BottomBarView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      FlutterNativeSplash.remove();

      if (context.read<UserProvider>().user.premium != true) {
        await Future.delayed(const Duration(milliseconds: 1500));
        await getIt<RouteService>().go(path: AppRoutes.subscriptions).then((_) {
          if (widget.firstOpen == true) {
            MixpanelService.track(type: EventType.instagramSheetOpened);
            followInstagram();
          }
        });
      }
    });
  }

  void followInstagram() {
    showCupertinoDialog(
      barrierDismissible: true,
      context: getIt<RouteService>().navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.dark,
          title: Column(
            children: [
              SizedBox(height: 20.h),
              Assets.icons.instagram.image(width: 60.w),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Text(
                  '🎁 Follow Us on Instagram & Get 40 Free Credits!',
                  style: AppStyles.medium(fontSize: 16, color: AppColors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Text(
                  'Just follow our official account and your credits will be added automatically.',
                  style: AppStyles.regular(fontSize: 12, color: AppColors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 8.h),
              CustomButton(
                title: 'Follow',
                onTap: () async {
                  MixpanelService.track(type: EventType.followInstagram);
                  launchInstagram().then((_) async {
                    await getIt<UserProvider>().updateUser();
                    getIt<UserProvider>().updateCoins(-40);
                    Navigator.of(context).pop();
                  });
                },
                backgroundColor: AppColors.first,
                textColor: AppColors.white,
              ),
              SizedBox(height: 8.h),
            ],
          ),
        );
      },
    );
  }

  Future<void> launchInstagram() async {
    try {
      await launchUrlString("instagram://user?username=luden.ai.app");
    } catch (err) {
      await launchUrlString("https://www.instagram.com/luden.ai.app/", mode: LaunchMode.externalApplication);
    }
  }
}
