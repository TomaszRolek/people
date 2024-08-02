import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'constants.dart';
import 'models/group.dart';
import 'models/person.dart';

class DatabaseHandler {
  static final DatabaseHandler instance = DatabaseHandler._internal();

  static Database? _database;

  DatabaseHandler._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'users.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, _) async {
    await db.execute('''
      CREATE TABLE ${PersonFields.tableName} (
        ${PersonFields.id} ${PersonFields.idType},
        ${PersonFields.firstName} ${PersonFields.textType},
        ${PersonFields.lastName} ${PersonFields.textType},
        ${PersonFields.birthDate} ${PersonFields.textType},
        ${PersonFields.address} ${PersonFields.textType},
        ${PersonFields.userGroups} ${PersonFields.textType}
      )
    ''');

    await db.execute('''
      CREATE TABLE ${GroupFields.tableName} (
        ${GroupFields.id} ${GroupFields.idType},
        ${GroupFields.name} ${GroupFields.textType},
        ${GroupFields.persons} ${GroupFields.textType}
      )
    ''');
  }

  Future<Person> createPerson(Person person) async {
    final db = await instance.database;
    final id = await db.insert(PersonFields.tableName, person.toJson());
    return person.copy(id: id);
  }

  Future<Group> createGroup(Group group) async {
    final db = await instance.database;
    final id = await db.insert(GroupFields.tableName, group.toJson());
    return group.copy(id: id);
  }

  Future<Person> readPerson(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      PersonFields.tableName,
      columns: PersonFields.values,
      where: '${PersonFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Person.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<Group> readGroup(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      GroupFields.tableName,
      columns: GroupFields.values,
      where: '${GroupFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Group.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Person>> readAllPersons() async {
    final db = await instance.database;
    final result = await db.query(PersonFields.tableName);
    return result.map((json) => Person.fromJson(json)).toList();
  }

  Future<List<Group>> readAllGroups() async {
    final db = await instance.database;
    final result = await db.query(GroupFields.tableName);
    return result.map((json) => Group.fromJson(json)).toList();
  }

  Future<int> updatePerson(Person person) async {
    final db = await instance.database;
    return db.update(
      PersonFields.tableName,
      person.toJson(),
      where: '${PersonFields.id} = ?',
      whereArgs: [person.id],
    );
  }

  Future<int> updateGroup(Group group) async {
    final db = await instance.database;
    return db.update(
      GroupFields.tableName,
      group.toJson(),
      where: '${GroupFields.id} = ?',
      whereArgs: [group.id],
    );
  }

  Future<int> deletePerson(int id) async {
    final db = await instance.database;
    return await db.delete(
      PersonFields.tableName,
      where: '${PersonFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteGroup(int id) async {
    final db = await instance.database;
    return await db.delete(
      GroupFields.tableName,
      where: '${GroupFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
