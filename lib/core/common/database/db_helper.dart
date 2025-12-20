import 'package:cartzy_app/core/utils/logging_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DBHelper {
  DBHelper._();
  static final DBHelper _instance = DBHelper._();
  factory DBHelper() => _instance;
  static const String _dbName = 'cartzy.db';
  static const int _dbVersion = 1;
  static Database? _db;

  /// Get database instance (Singleton)
  Future<Database> get instance async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  /// Initialize Database
  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// Create tables (First install only)
  Future<void> _onCreate(Database db, int version) async {
    // Favorites Table
    await db.execute('''
      CREATE TABLE favorites1 (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        slug TEXT NOT NULL,
        price DOUBLE NOT NULL,
        description TEXT NOT NULL,
        category TEXT NOT NULL,
        images TEXT NOT NULL,
        isFavorite INTEGER NOT NULL
      );
    ''');

    // Cart Table
    await db.execute('''
        CREATE TABLE cart (
          productId INTEGER UNIQUE NOT NULL,
          title TEXT NOT NULL,
          slug TEXT NOT NULL,
          quantity INTEGER NOT NULL,
          price DOUBLE NOT NULL,
          description TEXT NOT NULL,
          category TEXT NOT NULL,
          images TEXT NOT NULL,
          isFavorite INTEGER NOT NULL
        );
      ''');

    final tables =
        await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");

    LoggingService.instance.info('Created Tables: $tables');
  }

  /// Upgrade database (Versioning)
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  /// Close database
  Future<void> close() async {
    final db = await instance;
    await db.close();
  }
}
