import 'package:cartzy_app/feature/cart/data/database/cart_dao.dart';
import 'package:cartzy_app/feature/cart/data/model/response/cart_item_model.dart';
import 'package:cartzy_app/feature/cart/data/repo/data_source/cart_data_source.dart';

class CartDataSourceImpl implements CartDataSource {
  CartDao db = CartDao();

  @override
  Future<void> addItemToCart(CartItemModel cartItem) =>
      db.insertItemToCart(cartItem);

  @override
  Future<List<CartItemModel>> getAllCartItems() => db.getAllCartItems();

  @override
  Future<void> removeItemFromCart(int productId) =>
      db.deleteCartByProductId(productId);

  @override
  Future<void> updateItemInCart(CartItemModel cartItem) =>
      db.updateCartItem(cartItem);
}

CartDataSource injectCartDataSourceLocal() {
  return CartDataSourceImpl();
}
