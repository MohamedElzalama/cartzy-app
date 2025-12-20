import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/profile/data/model/response/user_model.dart';
import 'package:cartzy_app/feature/profile/data/repo/data_source/profile_data_source.dart';
import 'package:cartzy_app/feature/profile/data/repo/data_source/profile_data_source_impl.dart';
import 'package:cartzy_app/feature/profile/data/repo/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({required this.profileDataSource});
  final ProfileDataSource profileDataSource;
  @override
  Future<NetworkResult<UserModel>> getProfile() =>
      profileDataSource.getProfile();
}

ProfileRepository get injectProfileRepositoryImpl =>
    ProfileRepositoryImpl(profileDataSource: injectProfileDataSourceImpl);
