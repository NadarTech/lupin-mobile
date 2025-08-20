import 'package:dartz/dartz.dart';

import '../../../../core/base/model/error_model/base_error_model.dart';
import '../../../../core/consts/enum/http_type_enums.dart';
import '../../../../core/services/network/mapper/api_model_mapper.dart';
import '../../../../core/services/network/network_service.dart';
import '../model/coins_model.dart';

class CoinsDataSource {
  final NetworkService _networkService;

  CoinsDataSource(this._networkService);

  Future<Either<BaseErrorModel, CoinsModel>> sample({required CoinsModel coinsModel}) async {
    return _networkService.call(
      'sample', //AppEndpoints.sample,
      data: coinsModel.toJson(),
      mapper: (json) => APIModelMapper.jsonToItem(json, CoinsModel.fromJson),
      httpTypes: HttpTypes.post,
    );
  }
}
