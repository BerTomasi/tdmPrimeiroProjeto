import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'screens/list.dart';

void main() {
  runApp(TarefaApp());
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







