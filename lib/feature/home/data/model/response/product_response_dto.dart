import 'package:cartzy_app/feature/home/data/model/response/category_response_dto.dart';
import 'package:cartzy_app/feature/home/domain/entities/product_entity.dart';

class ProductResponseDto {
  ProductResponseDto({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
    this.creationAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  CategoryResponseDto? category;
  List<String>? images;
  String? creationAt;
  String? updatedAt;

  ProductResponseDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? CategoryResponseDto.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  ProductEntity toEntity() => ProductEntity(
        id: id!,
        title: title!,
        slug: slug!,
        price: price!,
        description: description!,
        category: category!.toEntity(),
        images: images!,
      );
}
