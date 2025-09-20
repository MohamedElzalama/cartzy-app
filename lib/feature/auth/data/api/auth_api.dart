import 'dart:convert';

import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/auth/data/model/request/login_request_dto.dart';
import 'package:cartzy_app/feature/auth/data/model/request/register_request_dto.dart';
import 'package:cartzy_app/feature/auth/data/model/response/login_response_dto.dart';
import 'package:cartzy_app/feature/auth/data/model/response/register_response_dto.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  AuthApi._();
  static AuthApi? _instance;
  static AuthApi get instance => _instance ??= AuthApi._();

  /// https://api.escuelajs.co/api/v1/users/
  Future<NetworkResult<RegisterResponseDto>> register(RegisterRequestDto request) async {
    try {
      Uri url = Uri.https("api.escuelajs.co", "/api/v1/users/");
      var response = await http.post(url, body: request.toJson());
      var json = jsonDecode(response.body);
      return NetworkSuccess(RegisterResponseDto.fromJson(json));
    } catch (e) {
      return NetworkError(e.toString());
    }
  }

  Future<NetworkResult<LoginResponseDto>> login(LoginRequestDto request) async {
    // https://api.escuelajs.co/api/v1/auth/login
    try {
      Uri url = Uri.https("api.escuelajs.co", "/api/v1/auth/login");
      var response = await http.post(url, body: request.toJson());
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NetworkSuccess(LoginResponseDto.fromJson(json));
    } catch (e) {
      return NetworkError(e.toString());
    }
  }
}
