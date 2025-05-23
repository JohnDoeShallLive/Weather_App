import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "weather_data.db";
  static const _databaseVersion = 1;

  static const table = 'weather';

  static const columnId = '_id';
  static const columnTemp = 'temperature';
  static const columnAirSpeed = 'air_speed';
  static const columnHumidity = 'humidity';
  static const columnDescription = 'description';
  static const columnMain = 'main';
  static const columnIcon = 'icon';
  static const columnCity = 'city';
  static const columnTime = 'time';
  static const columnDate = 'date';

  // Singleton instance
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTemp TEXT NOT NULL,
        $columnAirSpeed TEXT NOT NULL,
        $columnHumidity TEXT NOT NULL,
        $columnDescription TEXT NOT NULL,
        $columnMain TEXT NOT NULL,
        $columnIcon TEXT NOT NULL,
        $columnCity TEXT NOT NULL,
        $columnTime TEXT NOT NULL,
        $columnDate TEXT NOT NULL
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table, orderBy: "$columnId DESC");
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }
}
