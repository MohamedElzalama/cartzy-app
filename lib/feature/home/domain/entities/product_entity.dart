import 'package:cartzy_app/feature/home/domain/entities/category_entity.dart';

class ProductEntity {
  ProductEntity({
    this.id = 1,
    this.title = '',
    this.slug = '',
    this.price = 100,
    this.description = '',
    this.category = const CategoryEntity(),
    this.images = const [],
    this.isFavorite = false,
  });

  int id;
  String title;
  String slug;
  double price;
  String description;
  CategoryEntity category;
  List<String> images;
  bool isFavorite;
}
