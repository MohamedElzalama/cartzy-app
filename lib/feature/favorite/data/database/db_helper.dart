import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DBHelper {
  DBHelper._();
  static final _instance = DBHelper._();
  factory DBHelper() => _instance;

  static Database? _db;
  static const _dbName = 'cartzy.db';
  static const _dbVersion = 1;

  Future<Database> get instance async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE favorites1 (
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      slug TEXT NOT NULL,
      price INTEGER NOT NULL,
      description TEXT NOT NULL,
      category TEXT NOT NULL,
      images TEXT NOT NULL,
      isFavorite INTEGER NOT NULL
    );
      ''');
  }

  Future close() async {
    final db = await instance;
    db.close();
  }
}
