import 'package:flutter/material.dart';

import '../../../core/consts/end_point/app_end_points.dart';
import '../../../core/consts/enum/event_type.dart';
import '../../../core/consts/enum/http_type_enums.dart';
import '../../../core/consts/local/app_locals.dart';
import '../../../core/services/get_it/get_it_service.dart';
import '../../../core/services/mix_panel/mix_panel_service.dart';
import '../../../core/services/network/network_service.dart';
import '../../../core/services/storage/storage_service.dart';
import '../../../core/services/toast/toast_service.dart';
import '../../data_source/user_data_source.dart';
import '../../model/user/user_model.dart';

class UserProvider with ChangeNotifier {
  final UserDataSource _dataSource;
  late UserModel user = UserModel(id: '0', coins: 0, premium: false);

  UserProvider(this._dataSource);

  Future<void> getUser() async {
    final res = await _dataSource.getUser();
    return res.fold((error) => ToastService.warning(error.message), (response) {
      user = response;
      notifyListeners();
    });
  }

  Future<void> createUser({required String uuid}) async {
    final res = await _dataSource.createUser(uuid: uuid);
    return res.fold(
      (error) async {
        await MixpanelService.track(type: EventType.createUserError);
        ToastService.warning(error.message);
      },
      (response) async {
        await MixpanelService.track(type: EventType.createUser);
        await getIt<StorageService>().write(AppLocals.accessToken, response);
      },
    );
  }

  void updateCoins(int coins) {
    user.coins = user.coins - coins;
    notifyListeners();
  }

  Future<void> updateUser() async {
    await getIt<NetworkService>().call(AppEndpoints.updateUser, mapper: (_) {}, httpTypes: HttpTypes.get);
  }
}
