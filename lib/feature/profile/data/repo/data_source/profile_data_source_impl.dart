import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/profile/data/api/profile_api.dart';
import 'package:cartzy_app/feature/profile/data/model/response/user_model.dart';
import 'package:cartzy_app/feature/profile/data/repo/data_source/profile_data_source.dart';

class ProfileDataSourceImpl implements ProfileDataSource {
  ProfileDataSourceImpl({required this.profileApi});
  final ProfileApi profileApi;

  @override
  Future<NetworkResult<UserModel>> getProfile() => profileApi.getProfile();
}

ProfileDataSource get injectProfileDataSourceImpl =>
    ProfileDataSourceImpl(profileApi: ProfileApi.instance);
