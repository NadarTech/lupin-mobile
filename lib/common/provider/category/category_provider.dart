import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';

import '../../data_source/category_data_source.dart';
import '../../model/category/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryDataSource _dataSource;

  CategoryProvider(this._dataSource);

  final categories = <CategoryModel>[];
  final Map<String, List<VideoPlayerController>> allTemplateControllers = {};

  Future<void> getCategories() async {
    final res = await _dataSource.getCategories();
    res.fold((_) {}, (response) async {
      categories.clear();
      categories.addAll(response);
      notifyListeners();
    });
  }

/*
  Future<void> initVideos() async {
    for (var category in categories) {
      final List<VideoPlayerController> controllers = [];
      for (int i = 0; i < category.templates.length; i++) {
        var template = category.templates[i];
        final controller =
            VideoPlayerController.asset(
                template.video,
                videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
              )
              ..setLooping(true)
              ..setVolume(0);
        controllers.add(controller);
      }
      await Future.wait(controllers.map((c) => c.initialize()));
      await Future.wait(controllers.map((c) => c.dispose()));
      allTemplateControllers[category.title] = controllers;
      notifyListeners();
    }
  }

 */
  Future<void> initTemplateVideos() async {
    final cache = DefaultCacheManager();

    final futures = <Future>[];

    for (var category in categories) {
      for (final template in category.templates) {
        final url = template.videoUrl;
        if (url != null) {
          futures.add(_preloadVideo(cache, url));
        }
      }
    }

    await Future.wait(futures); // Hepsini paralel indirir
    print("✅ All videos cached.");
  }

  Future<void> _preloadVideo(BaseCacheManager cache, String url) async {
    try {
      final file = await cache.getFileFromCache(url);
      if (file == null) {
        await cache.downloadFile(url);
        print("✅ Cached: $url");
      } else {
        print("⚡ Already cached: $url");
      }
    } catch (e) {
      print("❌ Error caching $url: $e");
    }
  }
}
