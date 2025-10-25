import 'package:flutter/material.dart';
import 'package:luden/features/bottom_bar/presentation/view/bottom_bar_view.dart';
import 'package:luden/features/bottom_bar/presentation/view_model/bottom_bar_view_model.dart';
import 'package:luden/features/popular_video_detail/presentation/view_model/popular_video_detail_view_model.dart';
import 'package:provider/provider.dart';

import '../../../features/ai_models/presentation/view/ai_models_view.dart';
import '../../../features/coins/presentation/view/coins_view.dart';
import '../../../features/coins/presentation/view_model/coins_view_model.dart';
import '../../../features/completed_video/presentation/view/completed_video_view.dart';
import '../../../features/landing/presentation/view/landing_view.dart';
import '../../../features/onboarding/presentation/view/onboarding_view.dart';
import '../../../features/onboarding/presentation/view_model/onboarding_view_model.dart';
import '../../../features/popular_video_detail/presentation/view/popular_video_detail_view.dart';
import '../../../features/settings/presentation/view/settings_view.dart';
import '../../../features/subscriptions/presentation/view/subscriptions_view.dart';
import '../../../features/subscriptions/presentation/view_model/subscriptions_view_model.dart';
import '../../../features/trend_video_detail/presentation/view/trend_video_detail_view.dart';
import '../../../features/trend_video_detail/presentation/view_model/trend_video_detail_view_model.dart';
import '../../consts/route/app_routes.dart';
import '../get_it/get_it_service.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.landing:
        return MaterialPageRoute(
          builder: (context) => const LandingView(),
          settings: const RouteSettings(name: AppRoutes.landing),
        );
      case AppRoutes.onboarding:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) => getIt<OnboardingViewModel>(),
            child: OnboardingView(),
          ),
          settings: const RouteSettings(name: AppRoutes.onboarding),
        );
      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (context) => SettingsView(),
          settings: const RouteSettings(name: AppRoutes.settings),
        );
      case AppRoutes.bottomBar:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) => getIt<BottomBarViewModel>(),
            child: BottomBarView(firstOpen: args?['firstOpen']),
          ),
          settings: const RouteSettings(name: AppRoutes.bottomBar),
        );
      case AppRoutes.completedVideo:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => CompletedVideoView(video: args['video']),
          settings: const RouteSettings(name: AppRoutes.completedVideo),
        );
      case AppRoutes.coins:
        return MaterialPageRoute(
          builder: (context) =>
              ChangeNotifierProvider(create: (BuildContext context) => getIt<CoinsViewModel>(), child: CoinsView()),
          settings: const RouteSettings(name: AppRoutes.coins),
        );
      case AppRoutes.subscriptions:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) => getIt<SubscriptionsViewModel>(),
            child: SubscriptionsView(),
          ),
          settings: const RouteSettings(name: AppRoutes.subscriptions),
        );
      case AppRoutes.aiModels:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => AiModelsView(aiModels: args['aiModels']),
          settings: const RouteSettings(name: AppRoutes.aiModels),
        );
      case AppRoutes.trendVideoDetail:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) => getIt<TrendVideoDetailViewModel>(),
            child: TrendVideoDetailView(template: args['template']),
          ),
          settings: const RouteSettings(name: AppRoutes.trendVideoDetail),
        );
      case AppRoutes.popularVideoDetail:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) => getIt<PopularVideoDetailViewModel>(),
            child: PopularVideoDetailView(homeModel: args['homeModel']),
          ),
          settings: const RouteSettings(name: AppRoutes.popularVideoDetail),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const LandingView(),
          settings: const RouteSettings(name: AppRoutes.landing),
        );
    }
  }
}
