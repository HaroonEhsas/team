import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'attendance.db');
    return await openDatabase(
      path,
      version: 2, // Increase the version when modifying the schema
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE leaves (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            employee_id INTEGER,
            start_date TEXT,
            end_date TEXT,
            reason TEXT,
            status TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE teams (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            team_id INTEGER,
            title TEXT,
            description TEXT,
            deadline TEXT,
            FOREIGN KEY (team_id) REFERENCES teams(id)
          )
        ''');

        await db.execute('''
          CREATE TABLE shifts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            start_time TEXT,
            end_time TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE messages (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            sender_id INTEGER,
            receiver_id INTEGER,
            content TEXT,
            timestamp TEXT
          )
        ''');
      },
    );
  }

  // -------------------- LEAVES --------------------
  Future<List<Map<String, dynamic>>> getLeaves() async {
    final db = await database;
    return await db.query('leaves');
  }

  Future<int> applyLeave(Map<String, dynamic> leaveData) async {
    final db = await database;
    return await db.insert('leaves', leaveData);
  }

  // -------------------- TEAMS --------------------
  Future<List<Map<String, dynamic>>> getTeams() async {
    final db = await database;
    return await db.query('teams');
  }

  Future<int> createTeam(Map<String, dynamic> teamData) async {
    final db = await database;
    return await db.insert('teams', teamData);
  }

  // -------------------- TASKS --------------------
  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await database;
    return await db.query('tasks');
  }

  Future<int> createTask(Map<String, dynamic> taskData) async {
    final db = await database;
    return await db.insert('tasks', taskData);
  }

  // -------------------- SHIFTS --------------------
  Future<List<Map<String, dynamic>>> getShifts() async {
    final db = await database;
    return await db.query('shifts');
  }

  Future<int> createShift(Map<String, dynamic> shiftData) async {
    final db = await database;
    return await db.insert('shifts', shiftData);
  }

  // -------------------- MESSAGES --------------------
  Future<List<Map<String, dynamic>>> getMessages() async {
    final db = await database;
    return await db.query('messages');
  }

  Future<int> sendMessage(Map<String, dynamic> messageData) async {
    final db = await database;
    return await db.insert('messages', messageData);
  }
}
