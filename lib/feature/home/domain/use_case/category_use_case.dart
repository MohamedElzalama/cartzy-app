import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/home/data/repo/repository/home_repository_impl.dart';
import 'package:cartzy_app/feature/home/domain/entities/category_entity.dart';
import 'package:cartzy_app/feature/home/domain/repo/home_repository_contract.dart';

class CategoryUseCase {
  CategoryUseCase(this._repository);
  final HomeRepositoryContract _repository;

  Future<NetworkResult<List<CategoryEntity>>> call() =>
      _repository.getCategories();
}

injectCategoryUseCase() => CategoryUseCase(injectableHomeRepository());
