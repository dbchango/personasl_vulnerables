import 'dart:io';
import 'package:poblacion_vul/models/person.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider{
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    final path = join(appDir.path, 'Info.db');
    return await openDatabase(path, version:1, onOpen: (db){}, 
    onCreate: (Database db, int version) async{
      await db.execute(
        '''
        CREATE TABLE Persons(
          id INTEGER PRIMARY KEY,
          ci TEXT,
          name TEXT,
          lastname TEXT,
          borndate TEXT, 
          disability TEXT
        )
        '''
      );
    });
  }

  Future<int> create(Person person) async {
    final db = await database;
    final newId = await db.insert('Persons', person.toJson());
    return newId;
  }

  Future<dynamic> list() async{
    final db = await database;
    final result = await db.query('Persons');
    print(result);
    return result.isNotEmpty ? result.map((t)=> Person.fromJson(t)).toList()
    :[];
  }
    
}