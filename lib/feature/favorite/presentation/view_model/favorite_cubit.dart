// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cartzy_app/feature/favorite/data/model/response/favorite_model.dart';
import 'package:cartzy_app/feature/favorite/data/repo/repository/favorite_repository.dart';
import 'package:meta/meta.dart';
part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this.favoriteRepository) : super(FavoriteInitial());
  FavoriteRepository favoriteRepository;
  List<FavoriteModel> favoriteList = [];

  Future<void> addFavorite(FavoriteModel favoriteModel) async {
    emit(FavoriteLoading());
    await favoriteRepository.addFavorite(favoriteModel);
    emit(FavoriteSuccess());
  }

  Future<void> removeFavorite(int productId) async {
    emit(FavoriteLoading());
    await favoriteRepository.removeFavorite(productId);
    emit(FavoriteSuccess());
  }

  Future<void> getFavorites() async {
    emit(FavoriteLoading());
    var result = await favoriteRepository.getFavorites();
    favoriteList = result;
    emit(FavoriteSuccess());
  }
}
