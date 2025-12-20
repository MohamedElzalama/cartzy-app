import 'package:cartzy_app/feature/favorite/data/database/favorite_dao.dart';
import 'package:cartzy_app/feature/favorite/data/model/response/favorite_model.dart';
import 'package:cartzy_app/feature/favorite/data/repo/data_source/favorite_data_source.dart';

class FavoriteDataSourceLocalImpl implements FavoriteDataSourceLocal {
  FavoriteDao db = FavoriteDao();
  @override
  Future<void> addFavorite(FavoriteModel item) async =>
      await db.insertFavorite(item);

  @override
  Future<List<FavoriteModel>> getFavorites() async =>
      await db.getAllFavorites();

  @override
  Future<void> removeFavorite(int itemId) async =>
      await db.deleteFavoriteByProductId(itemId);
}

FavoriteDataSourceLocal injectFavoriteDataSourceLocal() {
  return FavoriteDataSourceLocalImpl();
}
