import 'package:cartzy_app/feature/home/domain/entities/category_entity.dart';

class CategoryResponseDto {
  CategoryResponseDto({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.creationAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? slug;
  String? image;
  String? creationAt;
  String? updatedAt;

  CategoryResponseDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  CategoryEntity toEntity() => CategoryEntity(
        id: id ?? 0,
        name: name ?? '',
        slug: slug ?? '',
        image: image ?? '',
      );
}
