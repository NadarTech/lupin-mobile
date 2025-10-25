import 'package:dartz/dartz.dart';

import '../../core/base/model/error_model/base_error_model.dart';
import '../../core/consts/end_point/app_end_points.dart';
import '../../core/consts/enum/http_type_enums.dart';
import '../../core/services/network/mapper/api_model_mapper.dart';
import '../../core/services/network/network_service.dart';
import '../model/category/category_model.dart';

class CategoryDataSource {
  final NetworkService _networkService;

  CategoryDataSource(this._networkService);

  Future<Either<BaseErrorModel, List<CategoryModel>>> getCategories() async {
    return await _networkService.call(
      AppEndpoints.category,
      mapper: (json) => APIModelMapper.jsonToList(json, CategoryModel.fromJson),
      httpTypes: HttpTypes.get,
    );
  }
}
