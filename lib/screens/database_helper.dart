import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'user.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;
  static final table = 'user_table';
  static final columnId = 'id';
  static final columnName = 'name';
  static final columnUsername = 'username';
  static final columnPassword = 'password';
  static final columnInterests = 'interests';
  static final columnImage = 'image';
  static final columnAge = 'age';
  static final columnSchool = 'school';

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only have a single app-wide reference to the database.
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  // Open the database and create it if it doesn't exist.
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onOpen: (db) {
      // Clear the database by dropping the table and recreating it
      db.execute('DROP TABLE IF EXISTS $table');
      _onCreate(db, _databaseVersion);
    });
  }

  // SQL code to create the database table.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnUsername TEXT NOT NULL,
            $columnPassword TEXT NOT NULL,
            $columnInterests TEXT NOT NULL,
            $columnImage TEXT NOT NULL,
            $columnAge TEXT NOT NULL,
            $columnSchool TEXT NOT NULL
          )
          ''');
  }

  // Insert a user into the database
  Future<void> insertUser(User user) async {
    Database db = await instance.database;
    await db.insert(
      table,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve all users from the database
  Future<List<User>> users() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  // Retrieve a user by username and password
  Future<User?> getUser(String username, String password) async {
    Database db = await instance.database;
    var res = await db.query(table,
        where: "$columnUsername = ? AND $columnPassword = ?",
        whereArgs: [username, password]);
    if (res.isNotEmpty) {
      return User.fromMap(res.first);
    }
    return null;
  }

  // Update a user in the database
  Future<void> updateUser(User user) async {
    Database db = await instance.database;
    await db.update(
      table,
      user.toMap(),
      where: "$columnId = ?",
      whereArgs: [user.id],
    );
  }

  // Delete a user from the database
  Future<void> deleteUser(int id) async {
    Database db = await instance.database;
    await db.delete(
      table,
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }

  Future<User?> getUserByUsername(String username) async {
    Database db = await instance.database;
    List<Map> maps = await db.query(table,
        columns: [
          columnId,
          columnName,
          columnUsername,
          columnPassword,
          columnInterests,
          columnImage,
          columnAge,
          columnSchool
        ],
        where: '$columnUsername = ?',
        whereArgs: [username]);

    if (maps.isNotEmpty) {
      // Cast the map to Map<String, dynamic> before passing it
      return User.fromMap(maps.first.cast<String, dynamic>());
    }
    return null;
  }
}
