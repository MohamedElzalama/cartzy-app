import 'package:bloc/bloc.dart';
import 'package:cartzy_app/core/utils/logging_service.dart';
import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/auth/data/model/request/login_request_dto.dart';
import 'package:cartzy_app/feature/auth/data/model/response/login_response_dto.dart';
import 'package:cartzy_app/feature/auth/data/repo/repository/auth_repository_contract.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._repository) : super(LoginInitial());
  final AuthRepositoryContract _repository;

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    final data = LoginRequestDto(
      email: email,
      password: password,
    );
    final result = await _repository.login(data);
    switch (result) {
      case NetworkSuccess<LoginResponseDto>():
        LoggingService.instance.debug("Login Success: $result");
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', result.data.accessToken!);
        await prefs.setString('email', email);
        await prefs.setString('password', password);
        emit(LoginSuccess());
      case NetworkError<LoginResponseDto>():
        emit(LoginError());
    }
  }
}
