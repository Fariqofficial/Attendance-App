import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static Database? _database;

  Future<Database> get db async {
    if (_database != null) return _database!;
    _database = await _initDB('attendance.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE locations (
        id TEXT PRIMARY KEY,
        name TEXT,
        latitude REAL,
        longitude REAL,
        radius REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE absensi (
        id TEXT PRIMARY KEY,
        location_id TEXT,
        timestamp TEXT,
        user_lat REAL,
        user_lng REAL,
        status TEXT
      )
    ''');
  }
}
