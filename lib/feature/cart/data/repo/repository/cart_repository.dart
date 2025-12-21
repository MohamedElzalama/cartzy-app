import 'package:cartzy_app/feature/cart/data/model/response/cart_item_model.dart';

abstract class CartRepository {
  Future<void> addItemToCart(CartItemModel cartItem);
  Future<void> removeItemFromCart(int productId);
  Future<List<CartItemModel>> getAllCartItems();
  Future<void> updateItemInCart(CartItemModel cartItem);
  Future<void> updateItemQuantity(int productId, int quantity);
}
