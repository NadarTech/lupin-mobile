import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/base/model/error_model/base_error_model.dart';
import '../../../../core/consts/end_point/app_end_points.dart';
import '../../../../core/consts/enum/http_type_enums.dart';
import '../../../../core/services/network/network_service.dart';

class TrendVideoDetailDataSource {
  final NetworkService _networkService;

  TrendVideoDetailDataSource(this._networkService);

  Future<Either<BaseErrorModel, void>> createVideo({required FormData formData}) async {
    return _networkService.call(
      AppEndpoints.video,
      fileRequest: true,
      formData: formData,
      mapper: (_) {},
      httpTypes: HttpTypes.post,
    );
  }
}
