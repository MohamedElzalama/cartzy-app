import 'package:cartzy_app/feature/cart/data/model/response/cart_item_model.dart';
import 'package:cartzy_app/feature/cart/presentation/view_model/cart_cubit.dart';
import 'package:cartzy_app/feature/cart/presentation/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CartBodyWidget extends StatefulWidget {
  CartBodyWidget({
    super.key,
    required this.cartItems,
    required this.cubit,
  });
  List<CartItemModel> cartItems;
  CartCubit cubit;

  @override
  State<CartBodyWidget> createState() => _CartBodyWidgetState();
}

class _CartBodyWidgetState extends State<CartBodyWidget> {
  @override
  initState() {
    super.initState();
    widget.cubit.calculateTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: ListView.separated(
              itemBuilder: (context, index) => CartItemWidget(
                cartItem: widget.cartItems[index],
                cubit: widget.cubit,
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: widget.cartItems.length,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff212121),
                        ),
                      ),
                      Text(
                        "EGP ${widget.cubit.totalPrice}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff212121),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    onPressed: () {},
                    color: Color(0xff212121),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
