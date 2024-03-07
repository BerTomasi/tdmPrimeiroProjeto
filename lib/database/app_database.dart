import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async{
  final String path = join(await getDatabasesPath(), 'dbtarefas.db');
  return openDatabase(path,
      onCreate: (db, version){
        db.execute('CREATE TABLE tarefas('
            'id INTEGER PRIMARY KEY, '
            'descricao TEXT, '
            'obs text)');
      },
      version:1
  );
}