import 'package:flutter/material.dart';
import 'package:primeiroprojeto/database/tarefa_dao.dart';
import '../components/editor.dart';
import '../model/tarefa.dart';

class FormTarefa extends StatefulWidget {

  final Tarefa? tarefa; // pode chegar com valor nulo -> por isso o uso do ?
  FormTarefa({this.tarefa}); // o { significa opcionalidade -> pode ou não chegar valor nulo

  final TextEditingController _controladorTarefa = TextEditingController();
  final TextEditingController _controladorObs = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return FormTarefaState();
  }
}

class FormTarefaState extends State<FormTarefa>{

  int? _id; // pode conter valor nulo

  @override
  void initState() {
    super.initState();
    if(widget.tarefa != null){ // significa que é uma alteração
      _id = widget.tarefa!.id; // ! -> significa que eu enquanto dev sei que tem uma info -> força a aceitar
      widget._controladorTarefa.text = widget.tarefa!.descricao;
      widget._controladorObs.text = widget.tarefa!.obs;
    }
  }  // pode conter valor nulo

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Form tarefa"),),
      body: Column(
        children: [
          Editor(widget._controladorTarefa, "Tarefa", "Indique a tarefa", Icons.assignment),
          Editor(widget._controladorObs, "OBS", "Escreva a observação", Icons.assignment),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          criarTerefa(context); // para criar um método: seleciona o código -> ctrl+alt+m
        },
        child: Icon(Icons.save),
      ),
    );

    // TODO: implement build
    throw UnimplementedError();
  }

  void criarTerefa(BuildContext context) {

    TarefaDao _dao = TarefaDao();

    if(_id != null){ // alteração
      final tarefaCriada = Tarefa(_id!, widget._controladorTarefa.text, widget._controladorObs.text);
      _dao.update(tarefaCriada).then((id){});
      Navigator.pop(context, tarefaCriada); // conceito de pilha, foi feito um push e agora um pop
    }else { //inclusão
      final tarefaCriada = Tarefa(0, widget._controladorTarefa.text, widget._controladorObs.text);
      print(tarefaCriada);
      _dao.save(tarefaCriada).then((id) {});
      Navigator.pop(context, tarefaCriada); // conceito de pilha, foi feito um push e agora um pop
    }
    final SnackBar snackBar = SnackBar(content: const Text("Tarefa criada")); // exibe uma mensagem ao fechar
    ScaffoldMessenger.of(context).showSnackBar(snackBar); // exibe a snackbar com a mensagem de a cima
    _dao.findAll().then((tarefa) => print(tarefa.toString()));
  }
}