import 'package:flutter/material.dart';
import 'package:primeiroprojeto/screens/gifs.dart';
import 'package:primeiroprojeto/screens/list.dart';

class MenuOptions extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MenuOptionsState();
  }
}

class MenuOptionsState extends State<MenuOptions>{

  int paginaAtual = 0;
  PageController ? pc;



  @override
  Widget build(BuildContext context) {
    return Scaffold( //esqueleto
      body: PageView( //vizualização
          controller: pc, // controlador
          children: [ // filhos
          ListaTarefa(),
          GifsPage(),
      ],
      onPageChanged: setPaginaAtual,
    ),
    bottomNavigationBar: BottomNavigationBar(
    currentIndex: paginaAtual,
    items: [
    BottomNavigationBarItem(icon: Icon(Icons.access_alarm), label: "Tarefas"),
    BottomNavigationBarItem(icon: Icon(Icons.gif), label: "Gifs"),
    ],
    onTap: (pagina ){// ao selecionar uma das posições
    pc?.animateToPage(pagina, duration: const Duration(microseconds: 400), curve: Curves.ease);
    },
    backgroundColor: Colors.grey[200],
    )
    ,
    );
  }

  setPaginaAtual(pagina){
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  void initState(){
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }
}