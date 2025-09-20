import 'package:cartzy_app/feature/home/domain/entities/category_entity.dart';

abstract class AppKeys {
  static const String emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static const String passwordRegex = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$';

  static const String usernameRegex = r'^[a-zA-Z0-9,.-]+$';

  static const String avatar = "https://picsum.photos/800";

  static const List<CategoryEntity> categories = [
    CategoryEntity(id: 1, name: "men's clothing"),
    CategoryEntity(id: 2, name: "jewelery"),
    CategoryEntity(id: 3, name: "electronics"),
    CategoryEntity(id: 4, name: "women's clothing"),
    CategoryEntity(id: 5, name: "men's clothing"),
    CategoryEntity(id: 6, name: "jewelery"),
    CategoryEntity(id: 7, name: "electronics"),
    CategoryEntity(id: 8, name: "women's clothing"),
  ];
}
