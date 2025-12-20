import 'package:bloc/bloc.dart';
import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/profile/data/model/response/user_model.dart';
import 'package:cartzy_app/feature/profile/data/repo/repository/profile_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepository) : super(ProfileInitial());
  ProfileRepository profileRepository;
  UserModel? user;

  Future<void> getProfile() async {
    emit(ProfileLoading());
    final response = await profileRepository.getProfile();
    if (isClosed) return;
    switch (response) {
      case NetworkSuccess<UserModel>():
        user = response.data;
        emit(ProfileSuccess());
      case NetworkError<UserModel>():
        emit(ProfileError());
    }
  }
}
