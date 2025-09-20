// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartzy_app/core/constants/app_assets.dart';
import 'package:cartzy_app/feature/home/domain/entities/product_entity.dart';
import 'package:cartzy_app/feature/home/presentation/view/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductItemWidget extends StatelessWidget {
  ProductItemWidget({super.key, required this.product});

  final ProductEntity product;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsScreen.routeName,
          arguments: product,
        );
      },
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
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border, color: Colors.red),
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
