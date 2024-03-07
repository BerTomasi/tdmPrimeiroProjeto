import 'package:primeiroprojeto/database/tarefa_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async{
  final String path = join(await getDatabasesPath(), 'dbtarefas.db');
  return openDatabase(path,
      onCreate: (db, version){
        db.execute(TarefaDao.tableSQL);
      },
      version:1
  );
}