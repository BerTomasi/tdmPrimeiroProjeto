import 'package:primeiroprojeto/database/tarefa_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async{

   const String tableSQL2 = 'CREATE TABLE cursos('
      'id INTEGER PRIMARY KEY, '
      'descricao TEXT, '
      'obs text)';

  final String path = join(await getDatabasesPath(), 'dbtarefas.db');
  return openDatabase(path,
      onCreate: (db, version){
        db.execute(TarefaDao.tableSQL);
      },

      onUpgrade: (db, oldVersion, newVersion) async{ // se tiver diferença entre a versão nova e a antiga ele executa a atualização
        var batch = db.batch();
        print("Versão antiga: " + oldVersion.toString());
        print("versão nova: " + newVersion.toString());
        if(newVersion == 2){
          batch.execute(tableSQL2);
        }
        await batch.commit();
      },
      version:2
  );
}