import 'dart:convert';

import 'package:cartzy_app/feature/home/domain/entities/category_entity.dart';

class FavoriteModel {
  final int id;
  final String title;
  final String slug;
  final double price;
  final String description;
  final CategoryEntity category;
  final List<String> images;
  bool isFavorite;

  FavoriteModel({
    this.id = 1,
    this.title = "",
    this.slug = "",
    this.price = 100,
    this.description = "",
    this.category = const CategoryEntity(),
    this.images = const [],
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'price': price,
      'description': description,
      'category': jsonEncode(category.toMap()),
      'images': jsonEncode(images),
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'] as int,
      title: map['title'] as String,
      slug: map['slug'] as String,
      price: map['price'],
      description: map['description'] as String,
      category: CategoryEntity.fromMap(jsonDecode(map['category'])),
      images: List<String>.from(jsonDecode(map['images'])),
      isFavorite: map['isFavorite'] == 1,
    );
  }
}
