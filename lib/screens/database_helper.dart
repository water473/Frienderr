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
  static final columnImagePath = 'imagePath';
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
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onOpen: (db) async {
        // Clear the database by dropping the table and recreating it
        await db.execute('DROP TABLE IF EXISTS $table');
        await _onCreate(db, _databaseVersion);

        // Insert five default users
        await _insertDefaultUser(
            db,
            'dmahairas',
            'Dimitrios Mahairas',
            '1234',
            '17',
            'Bronx Science',
            'Reading, Traveling',
            'assets/images/defaulat_dimitri.jpg');
        await _insertDefaultUser(
            db,
            'ntalukdar',
            'Navil Talukdar',
            '1234',
            '17',
            'Bronx Science',
            'Music, Gaming',
            'assets/images/navil_default.jpg');
        await _insertDefaultUser(
            db,
            'asirota',
            'Adam Sirota',
            '1234',
            '30',
            'Laguardia',
            'Movies, Technology',
            'assets/images/adam_default.jpg');
        await _insertDefaultUser(db, 'ljames', 'Lebron James', '1234', '35',
            'NBA', 'Basketball', 'assets/images/lebron_image.png');
        await _insertDefaultUser(db, 'alam101', 'Rakeen Alam', '1234', '16',
            'MSHS 141', 'Making Money', 'assets/images/rakeen_image.jpg');
        // ... Add two more default users ...
      },
    );
  }

// Helper method to insert a default user
  Future<void> _insertDefaultUser(
      Database db,
      String username,
      String name,
      String password,
      String age,
      String school,
      String interests,
      String imagePath) async {
    await db.insert(table, {
      'username': username,
      'name': name,
      'password': password,
      'age': age,
      'school': school,
      'interests': interests,
      'imagePath':
          imagePath, // Make sure this points to a valid image path or asset
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
            $columnImagePath TEXT NOT NULL,
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
          columnImagePath,
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
