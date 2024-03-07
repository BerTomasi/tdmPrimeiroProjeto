import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:primeiroprojeto/model/tarefa.dart';

class TarefaDao{

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

  Map<String, dynamic> toMap(Tarefa tarefa){
    final Map<String, dynamic> tarefaMap = Map();
    tarefaMap['descricao'] = tarefa.descricao;
    tarefaMap['obs'] = tarefa.obs;
    return tarefaMap;
  }

  // Método save -> inclusão de dados na tb
  Future<int> save(Tarefa tarefa) async{
    final Database db = await getDatabase();
    Map<String, dynamic> tarefaMap = toMap(tarefa);
    return db.insert('tarefa', tarefaMap);
  }

  // Método para a alteração
  Future<int> update(Tarefa tarefa) async{
    final Database db = await getDatabase();
    Map<String, dynamic> tarefaMap = toMap(tarefa);
    return db.update('tarefa', tarefaMap, where: 'id = ?', whereArgs: [tarefa.id]);
  }
}