import 'package:flutter/material.dart';
import '../model/tarefa.dart';
import '../screens/form.dart';

class ItemTarefa extends StatelessWidget{

  final Tarefa _tarefa; // "_" convenção do Dart -> é um objeto privado acessado somente dentro da classe
  const ItemTarefa(this._tarefa);

  @override
  Widget build(BuildContext context) { // construtor da tela
    return Card(
      child: ListTile(
        leading: Icon(Icons.add_alert),
        title: Text(this._tarefa.descricao),
        subtitle: Text(this._tarefa.obs),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}

// Stateful -> 2 classes -> 1 é o widget e a outra é o controlador
class ListaTarefa extends StatefulWidget {

  final List<Tarefa> _tarefas = [];

  // método que instância o estado -> cria o estado com base na outra classe
  @override
  State<StatefulWidget> createState() {
    return ListaTarefaState();
  } // vai alimentar a montagem da home

}

// controla o estado de ListaTarefa
class ListaTarefaState extends State<ListaTarefa>{

  @override
  Widget build(BuildContext context) {

    // tem que por o widget. para informar pra quem apontar
    // widget._tarefas.add(Tarefa("TCC2", "Fazer o Tcc2"));

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
      ),
      body: ListView.builder( // componente de listagem (exibição) -> cria uma rolagem e exibição

          itemCount: widget._tarefas.length, // contador de tarefas -> tamanho da lista _tarefas
          itemBuilder: (context, indice){
            final tarefa = widget._tarefas[indice]; // pega o item da lista no indice
            return ItemTarefa(tarefa);

          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print("Clicou no botão");

          final Future future = Navigator.push(context, //conceito de pilha -> fez um push
              MaterialPageRoute(builder: (context){
                return FormTarefa();
              }));
          future.then((tarefa){ // para esse obj future vamos ver se está capturando a tarefa
            print(tarefa); // está fazendo o retorno da tarefa criada na página

            widget._tarefas.add(tarefa); // adicionar a lista ->  para dar certo tem que mudar o objeto para statefull

            // gerenciamento de estado do flutter
            // aplicação que muda muita o estado recomenda-se o uso de outro método de gerenciamento que não o padrão da linguagem
            // reconstroi o build dessa classe
            setState(() {
              // reconstroi tudo -> a barra, botão, ... -> isso pode causar perda de desempenho
            });
          });
        },

        child: Icon(Icons.add),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}