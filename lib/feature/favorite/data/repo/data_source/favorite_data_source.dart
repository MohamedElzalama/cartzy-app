import 'package:cartzy_app/feature/favorite/data/model/response/favorite_model.dart';

abstract class FavoriteDataSourceLocal {
  Future<void> addFavorite(FavoriteModel itemId);
  Future<void> removeFavorite(int itemId);
  Future<List<FavoriteModel>> getFavorites();
}
