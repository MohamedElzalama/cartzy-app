import 'package:cartzy_app/feature/home/domain/entities/category_entity.dart';

abstract class AppAssets {
  static String dummyNetworkImage = 'https://i.imgur.com/QkIa5tT.jpeg';

  static String emptyProductListImage = 'assets/image/empty_product.png';

  static List<CategoryEntity> get dummyCategories => [
        CategoryEntity(
          id: 0,
          name: 'dymmy ',
          slug: 'dymmydymmydymmy  ',
          image: dummyNetworkImage,
        ),
        CategoryEntity(
          id: 0,
          name: 'dymmy ',
          slug: 'dymmydymmydymmy  ',
          image: dummyNetworkImage,
        ),
        CategoryEntity(
          id: 0,
          name: 'dymmy ',
          slug: 'dymmydymmydymmy  ',
          image: dummyNetworkImage,
        ),
        CategoryEntity(
          id: 0,
          name: 'dymmy ',
          slug: 'dymmydymmydymmy  ',
          image: dummyNetworkImage,
        ),
        CategoryEntity(
          id: 0,
          name: 'dymmy ',
          slug: 'dymmydymmydymmy  ',
          image: dummyNetworkImage,
        ),
      ];
}
