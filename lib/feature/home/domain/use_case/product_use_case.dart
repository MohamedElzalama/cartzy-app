import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/home/data/repo/repository/home_repository_impl.dart';
import 'package:cartzy_app/feature/home/domain/entities/product_entity.dart';
import 'package:cartzy_app/feature/home/domain/repo/home_repository_contract.dart';

class ProductUseCase {
  ProductUseCase(this._repository);
  final HomeRepositoryContract _repository;

  Future<NetworkResult<List<ProductEntity>>> call(int? categoryId) =>
      _repository.getProducts(categoryId);
}

ProductUseCase injectProductUseCase() =>
    ProductUseCase(injectableHomeRepository());
