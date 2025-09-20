// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/home/domain/entities/category_entity.dart';
import 'package:cartzy_app/feature/home/domain/entities/product_entity.dart';
import 'package:cartzy_app/feature/home/domain/use_case/category_use_case.dart';
import 'package:cartzy_app/feature/home/domain/use_case/product_use_case.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.categoryUseCase,
    required this.productUseCase,
  }) : super(HomeInitial());

  final CategoryUseCase categoryUseCase;
  final ProductUseCase productUseCase;

  List<CategoryEntity> categories = [
    CategoryEntity(
      id: 0,
      name: 'all',
    )
  ];
  List<ProductEntity> products = [];

  Future<void> getCategories() async {
    emit(CategoryLoading());
    var result = await categoryUseCase.call();
    if (isClosed) return;
    switch (result) {
      case NetworkSuccess<List<CategoryEntity>>():
        categories += result.data;
        emit(CategorySuccess(result.data));
      case NetworkError<List<CategoryEntity>>():
        emit(CategoryFailure(result.message));
    }
  }

  Future<void> getProducts(int? categoryId) async {
    emit(ProductLoading());
    var result = await productUseCase.call(categoryId);
    if (isClosed) return;
    switch (result) {
      case NetworkSuccess<List<ProductEntity>>():
        products = result.data;
        emit(ProductSuccess(result.data));
      case NetworkError<List<ProductEntity>>():
        emit(ProductFailure(result.message));
    }
  }
}
