import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import '../../../common/data_source/user_data_source.dart';
import '../../../common/provider/user/user_provider.dart';
import '../../../features/coins/presentation/view_model/coins_view_model.dart';
import '../../../features/generate_by_fal_ai/data/data_source/generate_by_fal_ai_data_source.dart';
import '../../../features/generate_by_fal_ai/presentation/view_model/generate_by_fal_ai_view_model.dart';
import '../../../features/home/presentation/view_model/home_view_model.dart';
import '../../../features/my_videos/data/data_source/my_videos_data_source.dart';
import '../../../features/my_videos/presentation/view_model/my_videos_view_model.dart';
import '../../../features/onboarding/presentation/view_model/onboarding_view_model.dart';
import '../../../features/subscriptions/presentation/view_model/subscriptions_view_model.dart';
import '../../../features/trend_video_detail/data/data_source/trend_video_detail_data_source.dart';
import '../../../features/trend_video_detail/presentation/view_model/trend_video_detail_view_model.dart';
import '../local/local_service.dart';
import '../network/network_service.dart';
import '../route/route_service.dart';
import '../storage/storage_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<StorageService>(StorageService());
  getIt.registerSingleton<LocalService>(LocalService(GetStorage()));
  getIt.registerSingleton<NetworkService>(NetworkService(Dio(), getIt<StorageService>())).init();
  getIt.registerSingleton<RouteService>(RouteService());
  getIt.registerSingleton<UserProvider>(UserProvider(UserDataSource(getIt<NetworkService>())));
  getIt.registerFactory<HomeViewModel>(() => HomeViewModel());
  getIt.registerFactory<MyVideosViewModel>(() => MyVideosViewModel(MyVideosDataSource(getIt<NetworkService>())));
  getIt.registerFactory<CoinsViewModel>(() => CoinsViewModel());
  getIt.registerFactory<SubscriptionsViewModel>(() => SubscriptionsViewModel());
  getIt.registerFactory<GenerateByFalAIViewModel>(
    () => GenerateByFalAIViewModel(GenerateByFalAIDataSource(getIt<NetworkService>())),
  );
  getIt.registerFactory<TrendVideoDetailViewModel>(
    () => TrendVideoDetailViewModel(TrendVideoDetailDataSource(getIt<NetworkService>())),
  );
  getIt.registerFactory<OnboardingViewModel>(() => OnboardingViewModel());
}
