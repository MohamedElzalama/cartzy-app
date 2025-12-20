import 'package:cartzy_app/core/constants/app_assets.dart';
import 'package:cartzy_app/feature/cart/presentation/view_model/cart_cubit.dart';
import 'package:cartzy_app/feature/cart/presentation/widgets/cart_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CartCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          bool isLoading = state is CartLoading;
          if (cubit.cartItems.isEmpty && !isLoading) {
            return const EmptyScreen(
              description: "Your cart is empty\nAdd items to get started",
              image: "assets/image/empty-cart.png",
            );
          }
          return Skeletonizer(
            enabled: isLoading,
            child: Column(
              spacing: 16,
              children: [
                Text(
                  "My Cart",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1F1F1F),
                  ),
                ),
                CartBodyWidget(
                  cartItems:
                      isLoading ? AppAssets.dummyCartItems : cubit.cartItems,
                  cubit: cubit,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    super.key,
    required this.description,
    required this.image,
  });
  final String description;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 24,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "My Cart",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xff1F1F1F),
            ),
          ),
          Spacer(),
          Image.asset(image),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Color(0xff5C5C5C),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
