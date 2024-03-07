import 'package:flutter/material.dart';
import '../components/editor.dart';
import '../model/tarefa.dart';

class FormTarefa extends StatelessWidget{

  final TextEditingController _controladorTarefa = TextEditingController();
  final TextEditingController _controladorObs = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Form tarefa"),),
      body: Column(
        children: [
          Editor(_controladorTarefa, "Tarefa", "Indique a tarefa", Icons.assignment),
          Editor(_controladorObs, "OBS", "Escreva a observação", Icons.assignment),
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
    final tarefaCriada = Tarefa(_controladorTarefa.text, _controladorObs.text);
    print(tarefaCriada);

    Navigator.pop(context, tarefaCriada); // conceito de pilha, foi feito um push e agora um pop

    final SnackBar snackBar = SnackBar(content: const Text("Tarefa criada")); // exibe uma mensagem ao fechar
    ScaffoldMessenger.of(context).showSnackBar(snackBar); // exibe a snackbar com a mensagem de a cima
  }

}