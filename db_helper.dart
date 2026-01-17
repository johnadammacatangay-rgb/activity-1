import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/student_model.dart';

class DBHelper {
  static Future<Database> initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'students.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );
  }

  static Future<int> insertStudent(Student student) async {
    final db = await initDB();
    return await db.insert('students', student.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Student>> getStudents() async {
    final db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('students');
    return List.generate(maps.length, (i) => Student.fromMap(maps[i]));
  }

  static Future<int> updateStudent(Student student) async {
    final db = await initDB();
    return await db.update('students', student.toMap(),
        where: 'id = ?', whereArgs: [student.id]);
  }

  static Future<int> deleteStudent(int id) async {
    final db = await initDB();
    return await db.delete('students', where: 'id = ?', whereArgs: [id]);
  }
}
