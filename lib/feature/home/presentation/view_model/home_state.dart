part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class CategoryLoading extends HomeState {}

class CategorySuccess extends HomeState {
  final List<CategoryEntity> categories;
  CategorySuccess(this.categories);
}

class CategoryFailure extends HomeState {
  final String message;
  CategoryFailure(this.message);
}

class ProductLoading extends HomeState {}

class ProductSuccess extends HomeState {
  final List<ProductEntity> products;
  ProductSuccess(this.products);
}

class ProductFailure extends HomeState {
  final String message;
  ProductFailure(this.message);
}
