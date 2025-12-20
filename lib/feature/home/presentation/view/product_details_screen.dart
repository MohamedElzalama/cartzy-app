// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartzy_app/core/constants/app_assets.dart';
import 'package:cartzy_app/core/dialogs/app_toasts.dart';
import 'package:cartzy_app/feature/cart/data/database/cart_dao.dart';
import 'package:cartzy_app/feature/cart/data/model/response/cart_item_model.dart';
import 'package:cartzy_app/feature/favorite/data/database/favorite_dao.dart';
import 'package:cartzy_app/feature/favorite/data/model/response/favorite_model.dart';
import 'package:cartzy_app/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:toastification/toastification.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});
  static const routeName = 'ProductDetailsScreen';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int index = 0;
  PageController controller = PageController();
  bool cartMode = false;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final ProductEntity product =
        ModalRoute.of(context)!.settings.arguments as ProductEntity;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        //! product body
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
        child: Row(
          spacing: 16,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  if (!cartMode) {
                    cartMode = true;
                    setState(() {});
                  } else {
                    //add to cart action
                    var cartProduct = CartItemModel(
                      productId: product.id,
                      title: product.title,
                      price: product.price,
                      description: product.description,
                      images: product.images,
                      category: product.category,
                      slug: product.slug,
                      isFavorite: product.isFavorite,
                      quantity: quantity,
                    );
                    await CartDao().insertItemToCart(cartProduct);
                    AppToast.showToast(
                      // ignore: use_build_context_synchronously
                      context: context,
                      title: "Added to cart",
                      description:
                          "${product.title} has been added to your cart.",
                      type: ToastificationType.success,
                    );
                    quantity = 1;
                    cartMode = false;
                    setState(() {});
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  cartMode ? "Add to cart" : "Want to buy?",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            cartMode
                ? Expanded(
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey, width: 1.5),
                      ),
                      child: Row(
                        spacing: 16,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (quantity > 1) {
                                quantity--;
                                setState(() {});
                              }
                            },
                            icon: Icon(
                              Icons.remove,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              quantity++;
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
