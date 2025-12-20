import 'package:cartzy_app/feature/cart/data/model/response/cart_item_model.dart';
import 'package:cartzy_app/feature/cart/presentation/view_model/cart_cubit.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CartItemWidget extends StatelessWidget {
  CartItemWidget({
    super.key,
    required this.cartItem,
    required this.cubit,
  });
  CartItemModel cartItem;
  CartCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffF4F4F4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              cartItem.images[0],
              width: 100,
              height: 100,
            ),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  cartItem.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff212121),
                    height: 1.2,
                  ),
                ),
              ),
              Text(
                "EGP ${cartItem.price}",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff212121),
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () async {
                  await cubit.removeItemFromCart(cartItem.productId);
                  await cubit.getAllCartItems();
                },
                icon: Icon(
                  Icons.cancel_outlined,
                  size: 30,
                  color: Color(0xff212121),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffF4F4F4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (cartItem.quantity > 1)
                      IconButton(
                        onPressed: () async {
                          // Decrease quantity logic here
                          await cubit.updateItemCart(CartItemModel(
                            productId: cartItem.productId,
                            title: cartItem.title,
                            price: cartItem.price,
                            images: cartItem.images,
                            quantity: cartItem.quantity - 1,
                          ));
                          await cubit.getAllCartItems();
                        },
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: Color(0xff212121),
                        ),
                      ),
                    Text(
                      "${cartItem.quantity}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff212121),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Increase quantity logic here
                        cubit.updateItemCart(CartItemModel(
                          productId: cartItem.productId,
                          title: cartItem.title,
                          price: cartItem.price,
                          images: cartItem.images,
                          quantity: cartItem.quantity + 1,
                          category: cartItem.category,
                          description: cartItem.description,
                          isFavorite: cartItem.isFavorite,
                          slug: cartItem.slug,
                        ));
                        cubit.getAllCartItems();
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Color(0xff212121),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
