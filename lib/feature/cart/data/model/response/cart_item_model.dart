import 'dart:convert';
import 'package:cartzy_app/feature/home/domain/entities/category_entity.dart';

class CartItemModel {
  final int productId;
  final String title;
  final String slug;
  final double price;
  final int quantity;
  final String description;
  final CategoryEntity category;
  final List<String> images;
  bool isFavorite;

  CartItemModel({
    this.productId = 1,
    this.title = "",
    this.slug = "",
    this.quantity = 1,
    this.price = 100,
    this.description = "",
    this.category = const CategoryEntity(),
    this.images = const [],
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'slug': slug,
      'quantity': quantity,
      'price': price,
      'description': description,
      'category': jsonEncode(category.toMap()),
      'images': jsonEncode(images),
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      productId: map['productId'] as int,
      title: map['title'] as String,
      slug: map['slug'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as double,
      description: map['description'] as String,
      category: CategoryEntity.fromMap(jsonDecode(map['category'])),
      images: List<String>.from(jsonDecode(map['images'])),
      isFavorite: map['isFavorite'] == 1,
    );
  }
}
