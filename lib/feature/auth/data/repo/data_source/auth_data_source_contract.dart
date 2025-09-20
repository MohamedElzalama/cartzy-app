import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/auth/data/model/request/login_request_dto.dart';
import 'package:cartzy_app/feature/auth/data/model/request/register_request_dto.dart';
import 'package:cartzy_app/feature/auth/data/model/response/login_response_dto.dart';
import 'package:cartzy_app/feature/auth/data/model/response/register_response_dto.dart';

abstract class AuthRemoteDataSourceContract {
  Future<NetworkResult<RegisterResponseDto>> register(RegisterRequestDto request);
  Future<NetworkResult<LoginResponseDto>> login(LoginRequestDto request);
}

abstract class AuthLocalDataSourceContract {}
