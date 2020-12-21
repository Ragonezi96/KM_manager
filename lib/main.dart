import 'package:sql_lite/views/consumo.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/consumo.controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<ConsumoController>.value(
            value: ConsumoController(),
          ),
        ],
        child: MaterialApp(
          title: 'Lista',
          debugShowCheckedModeBanner: false,
          home: ConsumoListView(),
        ));
  }
}
