import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteProvider {
  Database db;

  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'notes.db'),
        version: 1, onCreate: (Database db, int version) async {
      db.execute('''
        'create table Notes (
        id integer primary key autoincrement, 
        title text not nul,
        text text not null)'
      ''');
    });
  }

  Future<List<Map<String, dynamic>>>getNoteList()async{
    if(db==null){
      await open();
    }
    return await db.query('Notes');
  }
}
