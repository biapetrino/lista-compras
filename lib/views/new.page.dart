import 'package:flutter/material.dart';
import 'package:lista_compras/models/listacompras.model.dart';
import 'package:lista_compras/repository/listacompras.repository.dart';

class NewPage extends StatelessWidget {
  final _formKeyd = GlobalKey<FormState>();

  final _formKeyq = GlobalKey<FormState>();

  final _compras = ListaCompras();

  final _repository = ListaComprasRepository();

  salvar(BuildContext context) {
    {
      if (_formKeyd.currentState.validate() &
          _formKeyq.currentState.validate()) {
        _formKeyd.currentState.save();
        _formKeyq.currentState.save();
        _repository.create(_compras);
        Navigator.of(context).pop(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Novo Item'),
        centerTitle: true,
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () => salvar(context),
            child: Text(
              'Salvar',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            Flexible(
              child: Form(
                key: _formKeyd,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Descrição",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => _compras.descricao = value,
                  validator: (value) =>
                      value.isEmpty ? "Campo obrigatório" : null,
                ),
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  Form(
                    key: _formKeyq,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Quantidade",
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) => _compras.quantidade = value,
                      validator: (value) =>
                          value.isEmpty ? "Campo obrigatório" : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
