import 'package:cartzy_app/feature/cart/data/model/response/cart_item_model.dart';
import 'package:cartzy_app/feature/cart/data/repo/data_source/cart_data_source.dart';
import 'package:cartzy_app/feature/cart/data/repo/data_source/cart_data_source_impl.dart';
import 'package:cartzy_app/feature/cart/data/repo/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl(this.dataSourceLocal);
  CartDataSource dataSourceLocal;
  @override
  Future<void> addItemToCart(CartItemModel cartItem) async =>
      await dataSourceLocal.addItemToCart(cartItem);

  @override
  Future<List<CartItemModel>> getAllCartItems() async =>
      await dataSourceLocal.getAllCartItems();
  @override
  Future<void> removeItemFromCart(int productId) async =>
      await dataSourceLocal.removeItemFromCart(productId);

  @override
  Future<void> updateItemInCart(CartItemModel cartItem) async =>
      await dataSourceLocal.updateItemInCart(cartItem);
}

CartRepository injectCartRepository() {
  return CartRepositoryImpl(injectCartDataSourceLocal());
}
