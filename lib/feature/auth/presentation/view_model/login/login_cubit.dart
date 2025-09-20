import 'package:bloc/bloc.dart';
import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/auth/data/model/request/login_request_dto.dart';
import 'package:cartzy_app/feature/auth/data/model/response/login_response_dto.dart';
import 'package:cartzy_app/feature/auth/data/repo/repository/auth_repository_contract.dart';
import 'package:flutter/material.dart';

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
        emit(LoginSuccess());
      case NetworkError<LoginResponseDto>():
        emit(LoginError());
    }
  }
}
