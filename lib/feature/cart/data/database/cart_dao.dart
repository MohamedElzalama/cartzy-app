import 'package:cartzy_app/core/common/database/db_helper.dart';
import 'package:cartzy_app/feature/cart/data/model/response/cart_item_model.dart';
import 'package:sqflite/sqflite.dart';

class CartDao {
  final DBHelper _dbHelper = DBHelper();

  Future<int> insertItemToCart(CartItemModel cartItem) async {
    final db = await _dbHelper.instance;
    return await db.insert(
      'cart',
      cartItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateCartItem(CartItemModel cartItem) async {
    final db = await _dbHelper.instance;
    await db.update(
      'cart',
      cartItem.toMap(),
      where: 'productId = ?',
      whereArgs: [cartItem.productId],
    );
  }

  Future<void> updateCartItemQuantity(int productId, int quantity) async {
    final db = await _dbHelper.instance;
    await db.update(
      'cart',
      {'quantity': quantity},
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  Future<void> updateCartItemPrice(int productId, double price) async {
    final db = await _dbHelper.instance;
    await db.update(
      'cart',
      {'price': price},
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  Future<void> updateCartItemIsFavorite(int productId, bool isFavorite) async {
    final db = await _dbHelper.instance;
    await db.update(
      'cart',
      {'isFavorite': isFavorite ? 1 : 0},
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  Future<int> deleteCartByProductId(int productId) async {
    final db = await _dbHelper.instance;
    return await db.delete(
      'cart',
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  Future<List<CartItemModel>> getAllCartItems() async {
    final db = await _dbHelper.instance;
    final maps = await db.query('cart', orderBy: 'productId DESC');
    return maps.map((m) => CartItemModel.fromMap(m)).toList();
  }

  Future<void> clearCart() async {
    final db = await _dbHelper.instance;
    await db.delete('cart');
  }

  // Future<CartItemModel?> getCartByProductId(int productId) async {
  //   final db = await _dbHelper.instance;
  //   final maps = await db.query(
  //     'cart',
  //     where: 'id = ?',
  //     whereArgs: [productId],
  //     limit: 1,
  //   );
  //   if (maps.isNotEmpty) return CartItemModel.fromMap(maps.first);
  //   return null;
  // }
}
