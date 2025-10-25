import 'package:dartz/dartz.dart';

import '../../../../common/model/video/video_model.dart';
import '../../../../core/base/model/error_model/base_error_model.dart';
import '../../../../core/consts/end_point/app_end_points.dart';
import '../../../../core/consts/enum/http_type_enums.dart';
import '../../../../core/services/network/mapper/api_model_mapper.dart';
import '../../../../core/services/network/network_service.dart';

class MyVideosDataSource {
  final NetworkService _networkService;

  MyVideosDataSource(this._networkService);

  Future<Either<BaseErrorModel, List<VideoModel>>> getVideos() async {
    return _networkService.call(
      AppEndpoints.getVideos,
      mapper: (json) => APIModelMapper.jsonToList(json, VideoModel.fromJson),
      httpTypes: HttpTypes.get,
    );
  }
}
