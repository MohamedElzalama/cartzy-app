// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartzy_app/core/constants/app_assets.dart';
import 'package:cartzy_app/feature/favorite/data/database/favorite_dao.dart';
import 'package:cartzy_app/feature/favorite/data/model/response/favorite_model.dart';
import 'package:cartzy_app/feature/home/domain/entities/product_entity.dart';
import 'package:cartzy_app/feature/home/presentation/view/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({super.key, required this.product});
  final ProductEntity product;

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final fav = await FavoriteDao().getFavoriteByProductId(widget.product.id);
    if (fav != null) {
      setState(() {
        widget.product.isFavorite = fav.isFavorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsScreen.routeName,
          arguments: widget.product,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: widget.product.images[0],
                imageBuilder: (context, imageProvider) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.product.images[0],
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
                  onPressed: () async {
                    widget.product.isFavorite = !widget.product.isFavorite;
                    if (widget.product.isFavorite) {
                      await FavoriteDao().insertFavorite(
                        FavoriteModel(
                          id: widget.product.id,
                          title: widget.product.title,
                          price: widget.product.price,
                          description: widget.product.description,
                          category: widget.product.category,
                          images: widget.product.images,
                          isFavorite: widget.product.isFavorite,
                          slug: widget.product.slug,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Added to favorites"),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    } else {
                      await FavoriteDao()
                          .deleteFavoriteByProductId(widget.product.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Removed from favorites"),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    }
                    setState(() {});
                  },
                  icon: Icon(
                      shadows: [
                        Shadow(
                          color: Colors.white,
                          blurRadius: 10,
                        ),
                      ],
                      widget.product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red),
                ),
              )
            ],
          ),
          Expanded(
            child: Text(
              widget.product.title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xff212121),
              ),
            ),
          ),
          Text(
            "EGP ${widget.product.price}",
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
