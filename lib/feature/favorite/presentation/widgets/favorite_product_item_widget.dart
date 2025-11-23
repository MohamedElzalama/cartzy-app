// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartzy_app/core/constants/app_assets.dart';
import 'package:cartzy_app/feature/favorite/data/model/response/favorite_model.dart';
import 'package:cartzy_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoriteProductItemWidget extends StatelessWidget {
  FavoriteProductItemWidget({
    super.key,
    required this.product,
    required this.favoriteCubit,
  });

  final FavoriteModel product;
  FavoriteCubit favoriteCubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: product.images[0],
                imageBuilder: (context, imageProvider) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.images[0],
                    width: double.infinity,
                    height: 240,
                    fit: BoxFit.fill,
                  ),
                ),
                placeholder: (context, url) => Skeletonizer(
                  enabled: true,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      AppAssets.dummyNetworkImage,
                      width: double.infinity,
                      height: 240,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () {
                    product.isFavorite = !product.isFavorite;
                    favoriteCubit.removeFavorite(product.id).then((value) {
                      favoriteCubit.getFavorites();
                    });
                  },
                  icon: Icon(
                      shadows: [
                        Shadow(
                          color: Colors.white,
                          blurRadius: 10,
                        ),
                      ],
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red),
                ),
              )
            ],
          ),
          Expanded(
            child: Text(
              product.title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xff212121),
              ),
            ),
          ),
          Text(
            "EGP ${product.price}",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xff212121),
            ),
          ),
        ],
      ),
    );
  }
}
