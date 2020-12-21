import 'dart:ffi';

import 'package:sql_lite/controllers/consumo.controller.dart';
import 'package:sql_lite/models/consumo.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_lite/controllers/consumo.controller.dart';
import 'package:sql_lite/models/consumo.model.dart';
import 'package:sql_lite/views/cadastro.view.dart';
import 'package:sql_lite/views/monitor.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../app_status.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MonitorFormView extends StatefulWidget {
  final Consumo consumo;

  MonitorFormView({this.consumo});

  @override
  _MonitorFormViewState createState() => _MonitorFormViewState();
}



class _MonitorFormViewState extends State<MonitorFormView> {
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
  print('START');
    if (widget.consumo == null) {
      _consumo = Consumo();
      _isEdited = false;
    } else {
      _consumo = widget.consumo;
      _isEdited = true;
      _tId.text = _consumo.id.toString();
      _tvalorcombustivel.text = _consumo.valorcombustivel.toString();
      //_tkmatual.text = _consumo.kmatual.toString();
      _tkmatual.text = 'TESTE';
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
      
      enabled: false,
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
      int km_total = 0;
      int km_max = 0;
      int km_min = 999999999;
      double litros_total = 0 ;
      double avg_fuel = 0;
      double km_l = 0;
      int count = 0;
      _controller.getKM();
      for (var item in _controller.list) {
       if (km_max <item.kmatual ) {
         km_max = item.kmatual;
       }
       if (km_min > item.kmatual ) {
         km_min = item.kmatual;
       }
      litros_total = litros_total + item.litrosabastecidos;
      avg_fuel =avg_fuel + item.valorcombustivel;
      count++;
      //print(item.kmatual);
      //print(item.litrosabastecidos);
      }
       km_total = km_max - km_min;
      avg_fuel = avg_fuel/count;
      avg_fuel = num.parse(avg_fuel.toStringAsFixed(3));
      km_l = km_total/(litros_total - _controller.list[count-1].litrosabastecidos);
      km_l = num.parse(km_l.toStringAsFixed(3));
    return Scaffold(
      
      appBar: AppBar(
        title: Text("KM_Monitoring"),
        centerTitle: true,
      ),
      
      body: 
      
        RefreshIndicator(
        onRefresh: () async {
        print("começa lista");
        await _controller.getKM();
      
        },
       
        child: Container(
            child: SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

               
                _editText("Quilometragem total percorrida ${km_total}", _tkmatual, TextInputType.number),
                _editText("Litros abastecidos ${litros_total}", _tvalorcombustivel, TextInputType.number),
                _editText("KM/L  ${km_l}", _tdate, TextInputType.number),
                _editText("Media de combustivel ${avg_fuel}", _tlitrosabastecidos, TextInputType.number),
              
                
              ],
            ),
          )),
           
          
        ),
      ),);
  }  }
/*
  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<ConsumoController>(context);
    _controller.getKM();
    print("logo abaixo");

    
    return Scaffold(
      appBar: AppBar(
        title: Text("Monitoramento"),
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
              
                
              ],
            ),
          )),
    );
  }
}
*/