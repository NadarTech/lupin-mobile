import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../features/coins/presentation/view/coins_view.dart';
import '../../../features/coins/presentation/view_model/coins_view_model.dart';
import '../../../features/completed_video/presentation/view/completed_video_view.dart';
import '../../../features/generate_by_fal_ai/presentation/view/generate_by_fal_ai_view.dart';
import '../../../features/generate_by_fal_ai/presentation/view_model/generate_by_fal_ai_view_model.dart';
import '../../../features/home/presentation/view/home_view.dart';
import '../../../features/home/presentation/view_model/home_view_model.dart';
import '../../../features/landing/presentation/view/landing_view.dart';
import '../../../features/my_videos/presentation/view/my_videos_view.dart';
import '../../../features/my_videos/presentation/view_model/my_videos_view_model.dart';
import '../../../features/onboarding/presentation/view/onboarding_view.dart';
import '../../../features/onboarding/presentation/view_model/onboarding_view_model.dart';
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
      case AppRoutes.myVideos:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) => getIt<MyVideosViewModel>(),
            child: MyVideosView(),
          ),
          settings: const RouteSettings(name: AppRoutes.myVideos),
        );
      case AppRoutes.completedVideo:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => CompletedVideoView(video: args['video']),
          settings: const RouteSettings(name: AppRoutes.completedVideo),
        );
      case AppRoutes.generateByFalAI:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) => getIt<GenerateByFalAIViewModel>(),
            child: GenerateByFalAIView(),
          ),
          settings: const RouteSettings(name: AppRoutes.generateByFalAI),
        );
      case AppRoutes.coins:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) => getIt<CoinsViewModel>(),
            child: CoinsView(),
          ),
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
      case AppRoutes.trendVideoDetail:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) => getIt<TrendVideoDetailViewModel>(),
            child: TrendVideoDetailView(trendVideo: args['trendVideo']),
          ),
          settings: const RouteSettings(name: AppRoutes.trendVideoDetail),
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) =>
              ChangeNotifierProvider(create: (BuildContext context) => getIt<HomeViewModel>(), child: HomeView()),
          settings: const RouteSettings(name: AppRoutes.home),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const LandingView(),
          settings: const RouteSettings(name: AppRoutes.landing),
        );
    }
  }
}
