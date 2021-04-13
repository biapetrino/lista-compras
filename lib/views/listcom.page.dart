import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/models/listacompras.model.dart';
import 'package:lista_compras/repository/listacompras.repository.dart';

class ListCom extends StatefulWidget {
  @override
  _ListComState createState() => _ListComState();
}

class _ListComState extends State<ListCom> {
  final repositorio = ListaComprasRepository();

  List<ListaCompras> compras;

  @override
  initState() {
    super.initState();
    this.compras = repositorio.read();
  }

  Future addItem(BuildContext context) async {
    {
      var result = await Navigator.of(context).pushNamed('/new');
      if (result == true) {
        setState(() {
          this.compras = repositorio.read();
        });
      }
    }
  }

  Future<bool> confirmarDelete(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return AlertDialog(
            title: Text("Deseja excluir?"),
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                child: Text("Não"),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              // ignore: deprecated_member_use
              FlatButton(
                child: Text("Sim"),
                onPressed: () => Navigator.of(context).pop(true),
              )
            ],
          );
        });
  }

  bool editar = true;

  bool emfl = true;

  String ef = "";
  String eft = "";

  var cp = ListaCompras();

  void emfalta() {
    if (cp.emfalta == false) {
      eft = "EF";
      cp.emfalta = true;
    } else if (cp.emfalta == true) {
      eft = "";
      cp.emfalta = false;
    }
    setState(() {
      this.ef = eft;
      this.compras = repositorio.read();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Lista de Compras"),
          centerTitle: true),
      body: ListView.builder(
        itemCount: compras.length,
        itemBuilder: (_, indice) {
          var cp = compras[indice];
          return Dismissible(
            key: Key(cp.descricao),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                repositorio.delete(cp.descricao);
                setState(() => this.compras.remove(cp));
              } else if (direction == DismissDirection.startToEnd) {}
            },
            // ignore: missing_return
            confirmDismiss: (direction) {
              if (direction == DismissDirection.endToStart) {
                return confirmarDelete(context);
              }
            },
            child: CheckboxListTile(
                title: Row(
                  children: [
                    editar
                        ? IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              var rst = await Navigator.of(context).pushNamed(
                                '/editar',
                                arguments: cp,
                              );
                              if (rst) {
                                setState(
                                    () => this.compras = repositorio.read());
                              }
                            })
                        : Container(),
                    Text(
                      ef,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      cp.quantidade + " " + cp.descricao,
                      style: TextStyle(
                          decoration: cp.comprado
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                    SizedBox(
                      width: 200,
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(child: Text("Em falta"), onPressed: emfalta),
                  ],
                ),
                value: cp.comprado,
                onChanged: (value) {
                  compras.sort((a, b) => (a.comprado || b.comprado) ? -1 : 1);
                  setState(() => cp.comprado = value);
                  setState(() => this.compras = repositorio.read());
                }),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () => addItem(context),
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
