import 'package:sql_lite/controllers/consumo.controller.dart';
import 'package:sql_lite/models/consumo.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsumoFormView extends StatefulWidget {
  final Consumo consumo;

  ConsumoFormView({this.consumo});

  @override
  _ConsumoFormViewState createState() => _ConsumoFormViewState();
}



class _ConsumoFormViewState extends State<ConsumoFormView> {
  final _tId = TextEditingController();
  final _tvalorcombustivel = TextEditingController();
  final _tkmatual = TextEditingController();
  final _tlitrosabastecidos = TextEditingController();
  final _tdate = TextEditingController();
  final _tconcluido = TextEditingController();


  var _formKey = GlobalKey<FormState>();

  bool _isEdited = false;
  Consumo _consumo;

  @override
  void initState() {
    super.initState();

    if (widget.consumo == null) {
      _consumo = Consumo();
      _isEdited = false;
    } else {
      _consumo = widget.consumo;
      _isEdited = true;
      _tId.text = _consumo.id.toString();
      _tvalorcombustivel.text = _consumo.valorcombustivel.toString();
      _tkmatual.text = _consumo.kmatual.toString();
      _tlitrosabastecidos.text = _consumo.litrosabastecidos.toString();
      _tdate.text = _consumo.date;
      _tconcluido.text = _consumo.concluido.toString();

    }
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  // Widget EditText
  _editText(
      String field, TextEditingController controller, TextInputType type) {
    return TextFormField(
      enabled: true,
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: type,
      decoration: InputDecoration(
        labelText: field,
      ),
    );
  }



  

  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<ConsumoController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro KM"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _editText("Data(dd-mm-yyyy)", _tdate, TextInputType.text),
                _editText("Kilometragem atual", _tkmatual, TextInputType.number),
                _editText("Valor do litro", _tvalorcombustivel, TextInputType.number),
                _editText("Litros abastecidos", _tlitrosabastecidos, TextInputType.number),
              
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 20),
                  height: 45,
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      "Salvar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {

                        _consumo.date = _tdate.text;
                        _consumo.kmatual = int.parse(_tkmatual.text);
                        _consumo.litrosabastecidos = double.parse(_tlitrosabastecidos.text);
                        _consumo.valorcombustivel = double.parse(_tvalorcombustivel.text);
                        

                        if(_isEdited){
                          _consumo.id = int.parse(_tId.text);
                          _controller.update(Consumo( id: _consumo.id ,
                          date:   _consumo.date,
                          kmatual:  _consumo.kmatual,
                          litrosabastecidos:  _consumo.litrosabastecidos,
                          valorcombustivel : _consumo.valorcombustivel

                          ));
                      
                        }else{
                          _consumo.id = 0;
                          _controller.create(Consumo(date:   _consumo.date,
                          kmatual:  _consumo.kmatual,
                          litrosabastecidos:  _consumo.litrosabastecidos,
                          valorcombustivel : _consumo.valorcombustivel
                          ));
                          
                        }
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                if(_isEdited)
                  Container(
                    margin: EdgeInsets.only(top: 5.0, bottom: 5),
                    height: 45,
                    child: RaisedButton(
                      color: Colors.red,
                      child: Text(
                        "Remover",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()){

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: new Text("Exclusão de Registro"),
                                content: new Text("Tem certeza que deseja excluir este registro?"),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  FlatButton(
                                    child: new Text("Cancelar"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: new Text("Excluir"),
                                    onPressed: () {
                                      _controller.delete(_consumo.id);
                                      Navigator.of(context).pop();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );

                        }
                      },
                    ),
                  ),
              ],
            ),
          )),
    );
  }
}
