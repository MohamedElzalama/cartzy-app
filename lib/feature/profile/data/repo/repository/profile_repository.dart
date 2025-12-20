import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/profile/data/model/response/user_model.dart';

abstract class ProfileRepository {
  Future<NetworkResult<UserModel>> getProfile();
}
