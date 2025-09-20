import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/home/domain/entities/category_entity.dart';
import 'package:cartzy_app/feature/home/domain/entities/product_entity.dart';

abstract class HomeRepositoryContract {
  Future<NetworkResult<List<CategoryEntity>>> getCategories();

  Future<NetworkResult<List<ProductEntity>>> getProducts(int? categoryId);
}
