import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/book_model.dart';


abstract class BookLocalDataSource {
  Future<void> saveBook(BookModel book);
  Future<List<BookModel>> getSavedBooks();
}

class BookLocalDataSourceImpl implements BookLocalDataSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'books.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE books(
            id TEXT PRIMARY KEY,
            title TEXT,
            author TEXT,
            coverUrl TEXT
          )
        ''');
      },
    );
  }

  @override
  Future<void> saveBook(BookModel book) async {
    final db = await database;
    await db.insert(
      'books',
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<BookModel>> getSavedBooks() async {
    final db = await database;
    final maps = await db.query('books');
    return maps.map((map) => BookModel.fromMap(map)).toList();
  }
}
