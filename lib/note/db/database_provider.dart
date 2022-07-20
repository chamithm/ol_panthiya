
import 'package:multi_select_item/multi_select_item.dart';
import 'package:ol_panthiya/note/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider{
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database _database;

  

  Future<Database> get database async{
    print("database is $_database");
    if(_database != null){
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async{
    return await openDatabase(join(await getDatabasesPath(), "note_app.db"),
        onCreate: (db,version) async{
          await db.execute('''
            CREATE TABLE notes(
              id INTEGER,
              subject TEXT,
              title TEXT,
              body TEXT,
              creation_date DATE
            )
          ''');
        }, version: 1
    );
  }

  addNewNote(NoteModel note) async{
    print("subject : ${note.subject}");
    final db = await database;
    initDB();
    db.insert("notes", note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  updateNote(NoteModel note) async{
    print("chamith update");
    print("title: ${note.title}");
    print("note: ${note.body}");
    print("id : ${note.id}");
    final db = await database;
    initDB();
    // db.update("notes", note.toMap(),
    //   conflictAlgorithm: ConflictAlgorithm.replace
    // );
    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<dynamic> getNotes(String subject) async{
    final db = await database;
    //var res = await db.query("notes",where: subject);
    var res = await db.rawQuery('SELECT * FROM notes WHERE subject=?', [subject]);
    if(res.length == 0){
      return Null;
    }else{
      var resultMap = res.toList();
      return resultMap.isNotEmpty ? resultMap : Null;
    }
  }

  deleteData(int id) async{
    final db = await database;
    await db.rawDelete('DELETE FROM notes WHERE id = $id');
  }

}