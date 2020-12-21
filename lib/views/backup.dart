import 'package:sql_lite/controllers/consumo.controller.dart';
import 'package:sql_lite/models/consumo.model.dart';
import 'package:sql_lite/views/cadastro.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../app_status.dart';

class ConsumoListView extends StatefulWidget {
  @override
  _ConsumoListViewState createState() => _ConsumoListViewState();
}

class _ConsumoListViewState extends State<ConsumoListView> {
  final _formKey = GlobalKey<FormState>();
  var _itemController = TextEditingController();
  ConsumoController _controller = null;

  @override
  Widget build(BuildContext context) {
    _controller = Provider.of<ConsumoController>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Regitrador de KMs'), centerTitle: true),
      body: Scrollbar(
        child: Observer(builder: (_) {
          if (_controller.status == AppStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (_controller.status == AppStatus.success) {
            return ListView(
              children: [
                for (int i = 0; i < _controller.list.length; i++)
                  ListTile(
                      title: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: _controller.list[i].concluido
                        ? Text(
                            _controller.list[i].date,
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough),
                          )
                        : Text(_controller.list[i].date),
                    value: _controller.list[i].concluido,
                    secondary: IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 20.0,
                        color: Colors.red[900],
                      ),
                      onPressed: () async {
                        await _controller.delete(_controller.list[i].id);
                      },
                    ),
                    onChanged: (c) async {
                      Consumo edited = _controller.list[i];
                      edited.concluido = c;
                      await _controller.update(edited);
                    },
                  )),
              ],
            );
          } else {
            return Text("Carregando... ");
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _displayDialog(context),
      ),
    );
  }

  _displayDialog(context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: _itemController,
                validator: (s) {
                  if (s.isEmpty)
                    return "Digite o registro.";
                  else
                    return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Registro"),
                
              ),
              
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text('SALVAR'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _controller.create(
                        Consumo(date: _itemController.text, concluido: false));
                    _itemController.text = "";
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }
}



  