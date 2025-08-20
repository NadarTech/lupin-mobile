import 'package:dio/dio.dart';

import '../../../consts/enum/event_type.dart';
import '../../mix_panel/mix_panel_service.dart';

class NetworkHelper {
  final Dio dio;

  NetworkHelper(this.dio);

  Future<void> onError(DioException exception, ErrorInterceptorHandler handler) async {
    MixpanelService.track(
      type: EventType.httpError,
      args: {'endpoint': exception.requestOptions.path, 'error': exception.response?.data ?? ''},
    );
    handler.next(exception);
  }
}
