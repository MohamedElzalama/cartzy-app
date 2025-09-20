import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/home/data/api/home_api.dart';
import 'package:cartzy_app/feature/home/data/model/response/category_response_dto.dart';
import 'package:cartzy_app/feature/home/data/model/response/product_response_dto.dart';
import 'package:cartzy_app/feature/home/domain/entities/category_entity.dart';
import 'package:cartzy_app/feature/home/domain/entities/product_entity.dart';
import 'package:cartzy_app/feature/home/domain/repo/home_data_source_contract.dart';

class HomeDataSourceImpl implements HomeDataSourceContract {
  HomeDataSourceImpl(this._api);
  HomeApi _api;

  @override
  Future<NetworkResult<List<CategoryEntity>>> getCategories() async {
    var result = await _api.getCategories();
    switch (result) {
      case NetworkSuccess<List<CategoryResponseDto>>():
        return NetworkSuccess<List<CategoryEntity>>(
          result.data.map((e) => e.toEntity()).toList(),
        );

      case NetworkError<List<CategoryResponseDto>>():
        return NetworkError(result.message);
    }
  }

  @override
  Future<NetworkResult<List<ProductEntity>>> getProducts(
      int? categoryId) async {
    var result = await _api.getProducts(categoryId);
    switch (result) {
      case NetworkSuccess<List<ProductResponseDto>>():
        return NetworkSuccess<List<ProductEntity>>(
          result.data.map((e) => e.toEntity()).toList(),
        );
      case NetworkError<List<ProductResponseDto>>():
        return NetworkError(result.message);
    }
  }
}

HomeDataSourceContract injectableHomeDataSource() =>
    HomeDataSourceImpl(HomeApi.instance);
