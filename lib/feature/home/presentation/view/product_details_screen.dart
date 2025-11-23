// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartzy_app/core/constants/app_assets.dart';
import 'package:cartzy_app/feature/favorite/data/database/favorite_dao.dart';
import 'package:cartzy_app/feature/favorite/data/model/response/favorite_model.dart';
import 'package:cartzy_app/feature/home/domain/entities/product_entity.dart';
import 'package:cartzy_app/feature/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});
  static const routeName = 'ProductDetailsScreen';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int index = 0;
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    final ProductEntity product =
        ModalRoute.of(context)!.settings.arguments as ProductEntity;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          spacing: 20,
          children: [
            //! image
            Stack(
              children: [
                Container(
                  height: 330,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: controller,
                    onPageChanged: (value) {
                      index = value;
                      setState(() {});
                    },
                    itemBuilder: (context, index) => CachedNetworkImage(
                      imageUrl: product.images[index],
                      imageBuilder: (context, imageProvider) => ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          product.images[index],
                          width: double.infinity,
                          height: 330,
                          fit: BoxFit.cover,
                        ),
                      ),
                      placeholder: (context, url) => Skeletonizer(
                        enabled: true,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            AppAssets.dummyNetworkImage,
                            width: double.infinity,
                            height: 330,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    itemCount: product.images.length,
                  ),
                ),
                //! favorite
                Positioned(
                  top: 12,
                  right: 15,
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    child: IconButton(
                      onPressed: () async {
                        product.isFavorite = !product.isFavorite;
                        if (product.isFavorite) {
                          await FavoriteDao().insertFavorite(FavoriteModel(
                            id: product.id,
                            title: product.title,
                            price: product.price,
                            description: product.description,
                            images: product.images,
                            isFavorite: product.isFavorite,
                            category: product.category,
                            slug: product.slug,
                          ));
                        } else {
                          await FavoriteDao()
                              .deleteFavoriteByProductId(product.id);
                        }
                        setState(() {});
                      },
                      icon: Icon(
                          product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              product.isFavorite ? Colors.red : Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            //! indicator onboarding
            SmoothPageIndicator(
              controller: controller,
              count: product.images.length,
              axisDirection: Axis.horizontal,
              effect: ExpandingDotsEffect(
                dotWidth: 10,
                dotHeight: 10,
                dotColor: Color(0xffAFAFAF),
                activeDotColor: Color(0xff212121),
              ),
            ),
            //! title and price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //! title
                  Expanded(
                    child: Text(
                      product.title,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  //! price
                  Text(
                    "EGP ${product.price.toString()}",
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            //! description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                product.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
      //! add to cart
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Add to cart",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
