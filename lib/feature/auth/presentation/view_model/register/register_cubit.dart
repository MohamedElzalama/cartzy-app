import 'package:bloc/bloc.dart';
import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/auth/data/model/request/register_request_dto.dart';
import 'package:cartzy_app/feature/auth/data/model/response/register_response_dto.dart';
import 'package:cartzy_app/feature/auth/data/repo/repository/auth_repository_contract.dart';
import 'package:flutter/material.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._repository) : super(RegisterInitial());
  final AuthRepositoryContract _repository;

  Future<void> register(String name, String email, String password) async {
    emit(RegisterLoading());
    final request = RegisterRequestDto(
      name: name,
      password: password,
      email: email,
    );
    final result = await _repository.register(request);
    switch (result) {
      case NetworkSuccess<RegisterResponseDto>():
        emit(RegisterSuccess());
      case NetworkError<RegisterResponseDto>():
        emit(RegisterError());
    }
  }
}
