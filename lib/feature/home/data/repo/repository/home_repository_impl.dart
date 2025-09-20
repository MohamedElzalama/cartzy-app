import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/home/data/repo/data_source/home_data_source_impl.dart';
import 'package:cartzy_app/feature/home/domain/entities/category_entity.dart';
import 'package:cartzy_app/feature/home/domain/entities/product_entity.dart';
import 'package:cartzy_app/feature/home/domain/repo/home_data_source_contract.dart';
import 'package:cartzy_app/feature/home/domain/repo/home_repository_contract.dart';

class HomeRepositoryImpl implements HomeRepositoryContract {
  const HomeRepositoryImpl(this._dataSource);
  final HomeDataSourceContract _dataSource;

  @override
  Future<NetworkResult<List<CategoryEntity>>> getCategories() =>
      _dataSource.getCategories();

  @override
  Future<NetworkResult<List<ProductEntity>>> getProducts(int? categoryId) =>
      _dataSource.getProducts(categoryId);
}

HomeRepositoryContract injectableHomeRepository() =>
    HomeRepositoryImpl(injectableHomeDataSource());
