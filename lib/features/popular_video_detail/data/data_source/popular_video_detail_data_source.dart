import 'package:dartz/dartz.dart';
import 'package:luden/features/generate_by_fal_ai/data/model/generate_by_fal_ai_model.dart';

import '../../../../core/base/model/error_model/base_error_model.dart';
import '../../../../core/consts/end_point/app_end_points.dart';
import '../../../../core/consts/enum/http_type_enums.dart';
import '../../../../core/services/network/network_service.dart';

class PopularVideoDetailDataSource {
  final NetworkService _networkService;

  PopularVideoDetailDataSource(this._networkService);

  Future<Either<BaseErrorModel, void>> generateVideoByFalAI({required GenerateByFalAIModel addPromptModel}) async {
    return _networkService.call(
      AppEndpoints.generateVideoByFalAI,
      data: addPromptModel.toJson(),
      mapper: (_) {},
      httpTypes: HttpTypes.post,
    );
  }
}
