import 'package:path/path.dart' as path;
import 'package:phonebook_app/src/models/contact.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/strings.dart';

class DatabaseProvider {
  Future<Database> init() async {
    return await openDatabase(
      path.join(await getDatabasesPath(), dbName),
      version: 1,
      onCreate: (db, version) async {
        await _createDb(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < newVersion) {
          await _createDb(db);
        }
      },
    );
  }

  Future<void> _createDb(Database db) async {
    await db.execute('DROP TABLE IF EXISTS $contactTable');
    await db.execute('DROP TABLE IF EXISTS $contactTable');
    await db.execute(
      'CREATE TABLE $contactTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$columnName TEXT NOT NULL, $columnPhoneNo TEXT NOT NULL)',
    );
    await db.execute('CREATE INDEX contactName ON $contactTable ($columnName)');
  }

  Future<List<Contact>> fetch() async {
    final database = await init();
    final dataList = await database.query(
      contactTable,
      columns: [
        columnId,
        columnName,
        columnPhoneNo,
      ],
      orderBy: '$columnName ASC',
    );

    if (dataList.isEmpty) return [];

    return dataList.map((item) => Contact.fromMap(item)).toList();
  }

  Future insert(Contact contact) async {
    final database = await init();
    await database.insert(
      contactTable,
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future update(Contact contact) async {
    final database = await init();
    await database.update(
      contactTable,
      contact.toMap(),
      where: '$columnId = ?',
      whereArgs: [contact.id],
    );
  }

  Future delete(int? id) async {
    final database = await init();
    await database.delete(
      contactTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
