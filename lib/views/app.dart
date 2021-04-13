import 'package:flutter/material.dart';
import 'package:lista_compras/views/editar.page.dart';
import 'package:lista_compras/views/listcom.page.dart';
import 'package:lista_compras/views/new.page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => ListCom(),
        '/new': (context) => NewPage(),
        '/editar': (context) => EditarPage(),
      },
      initialRoute: '/',
    );
  }
}
