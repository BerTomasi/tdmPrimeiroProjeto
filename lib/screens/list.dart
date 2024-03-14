import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeiroprojeto/database/tarefa_dao.dart';
import '../model/tarefa.dart';
import '../screens/form.dart';



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

  final TarefaDao _dao = TarefaDao();

  @override
  Widget build(BuildContext context) {

    // tem que por o widget. para informar pra quem apontar
    // widget._tarefas.add(Tarefa("TCC2", "Fazer o Tcc2"));

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
      ),
      body: FutureBuilder<List<Tarefa>>( // construção que depende de algo que vai retornar do futuro -> lista de tarefas
        initialData: [],
        future: Future.delayed(Duration(seconds: 1)).then((value) => _dao.findAll()),
        builder: (context,snapshot){ // só termina de construir quando terminar de carregar tudo -> um tipo de conexão
          switch(snapshot.connectionState){
            case ConnectionState.done:
              if(snapshot.data!=null){
                final List<Tarefa>? tarefas = snapshot.data;
                return ListView.builder(itemBuilder: (context,index){
                  final Tarefa tarefa = tarefas![index];
                  return ItemTarefa(context, tarefa);
                },
                itemCount: tarefas!.length);
              }
              break;
            default:
              return Center(child:Text("Nenhuma tarefa"),);
          }
          return Center(child: Text("Carregando..."),);
        },
      ),
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

  Widget ItemTarefa (BuildContext context, Tarefa _tarefa){ //método que retorna um widget -> card
    return GestureDetector( // detecta um gesto
      onTap: (){

      }, // precionar, clicar, seleciona a região
      child: Card(
          child: ListTile(
            leading: Icon(Icons.add_alert), // icone do sino
            title: Text(_tarefa.descricao), // titulo
            subtitle: Text(_tarefa.obs), // obs
            trailing: Row( // elemento a mais a direita
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    _dao.delete(_tarefa.id).then((value) => setState(() {
                      // DELETA o elemento -> retorna um valor -> setstate: reconstroi o build -> atualiza o build
                    }));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.remove_circle, color: Colors.red),
                  ),
                )
              ],
            ),
          )),
    );
  }
}