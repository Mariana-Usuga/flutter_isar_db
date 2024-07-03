import 'package:flutter_isar_db/db/entities/entities.dart';
import 'package:flutter_isar_db/db/isar.dart';
import 'package:isar/isar.dart';

class StudentServices {
  late Future<Isar> db;

  StudentServices() {
    db = IsarService().db;
  }

  Future<List<Student>> getAllStudents() async {
    final isar = await db;
    return await isar.students.where().findAll();
  }

  Future<bool> saveStudent(Student newStudent) async {
    try {
      final isar = await db;
      await isar.writeTxn(() async {
        await isar.students.put(newStudent);
      });
      return true;
    } on IsarError catch (error) {
      throw Exception(error.message);
    }
  }
}
