import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/auth/data/api/auth_api.dart';
import 'package:cartzy_app/feature/auth/data/model/request/login_request_dto.dart';
import 'package:cartzy_app/feature/auth/data/model/request/register_request_dto.dart';
import 'package:cartzy_app/feature/auth/data/model/response/login_response_dto.dart';
import 'package:cartzy_app/feature/auth/data/model/response/register_response_dto.dart';
import 'package:cartzy_app/feature/auth/data/repo/data_source/auth_data_source_contract.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSourceContract {
  AuthRemoteDataSourceImpl(this._authApi);
  final AuthApi _authApi;
  @override
  Future<NetworkResult<RegisterResponseDto>> register(
          RegisterRequestDto request) =>
      _authApi.register(request);

  @override
  Future<NetworkResult<LoginResponseDto>> login(LoginRequestDto request) =>
      _authApi.login(request);
}

AuthRemoteDataSourceContract injectableAuthDataSource() =>
    AuthRemoteDataSourceImpl(AuthApi.instance);
