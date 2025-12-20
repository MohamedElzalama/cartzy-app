import 'package:cartzy_app/core/common/database/db_helper.dart';
import 'package:cartzy_app/feature/favorite/data/model/response/favorite_model.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDao {
  final DBHelper _dbHelper = DBHelper();

  Future<int> insertFavorite(FavoriteModel fav) async {
    final db = await _dbHelper.instance;
    return await db.insert(
      'favorites1',
      fav.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteFavoriteByProductId(int productId) async {
    final db = await _dbHelper.instance;
    return await db.delete(
      'favorites1',
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  Future<List<FavoriteModel>> getAllFavorites() async {
    final db = await _dbHelper.instance;
    final maps = await db.query('favorites1', orderBy: 'id DESC');
    return maps.map((m) => FavoriteModel.fromMap(m)).toList();
  }

  Future<FavoriteModel?> getFavoriteByProductId(int productId) async {
    final db = await _dbHelper.instance;
    final maps = await db.query(
      'favorites1',
      where: 'id = ?',
      whereArgs: [productId],
      limit: 1,
    );
    if (maps.isNotEmpty) return FavoriteModel.fromMap(maps.first);
    return null;
  }

  Future<void> clearFavorites() async {
    final db = await _dbHelper.instance;
    await db.delete('favorites1');
  }
}
