import 'package:cartzy_app/feature/favorite/data/model/response/favorite_model.dart';
import 'package:cartzy_app/feature/favorite/data/repo/data_source/favorite_data_source.dart';
import 'package:cartzy_app/feature/favorite/data/repo/data_source/favorite_data_source_impl.dart';
import 'package:cartzy_app/feature/favorite/data/repo/repository/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  FavoriteRepositoryImpl(this.dataSourceLocal);
  FavoriteDataSourceLocal dataSourceLocal;
  @override
  Future<void> addFavorite(FavoriteModel itemId) async =>
      await dataSourceLocal.addFavorite(itemId);

  @override
  Future<List<FavoriteModel>> getFavorites() async =>
      await dataSourceLocal.getFavorites();

  @override
  Future<void> removeFavorite(int itemId) async =>
      await dataSourceLocal.removeFavorite(itemId);
}

FavoriteRepository injectFavoriteRepository() {
  return FavoriteRepositoryImpl(injectFavoriteDataSourceLocal());
}
