import 'package:flutter/material.dart';
import 'screens/list.dart';
import 'database/tarefa_dao.dart';
import 'model/tarefa.dart';

void main() {
  runApp(TarefaApp());
  TarefaDao db = TarefaDao();
  db.save(Tarefa(0,"tarefa teste", 'obs teste')).then((id){
    print("id gerado: "+id.toString());
    db.findAll().then((tarefa) => print(tarefa.toString()));
  });
}

class TarefaApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: ListaTarefa()
    );

    // TODO: implement build
    throw UnimplementedError();
  }

}







