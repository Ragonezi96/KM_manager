import 'package:sql_lite/controllers/consumo.controller.dart';
import 'package:sql_lite/models/consumo.model.dart';
import 'package:sql_lite/views/cadastro.view.dart';
import 'package:sql_lite/views/monitor.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../app_status.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class ConsumoListView extends StatefulWidget {
  @override
  _ConsumoListViewState createState() => _ConsumoListViewState();
}


class _ConsumoListViewState extends State<ConsumoListView> {
  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<ConsumoController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("KM_manager"),
        centerTitle: true,
      ),
      body:  RefreshIndicator(
        onRefresh: () async {
          await _controller.getAll();
       
        },
    
        child: Container(
            child: Observer(builder: (_) {
              if (_controller.status == AppStatus.loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (_controller.status == AppStatus.success) {
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _controller.list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(_controller.list[index].date),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ConsumoFormView(consumo: _controller.list[index]),
                            ),
                          );
                        },
                      );
                    });
              } else {
                return Text("${_controller.status.value}");
              }
            }),
          
        ),
      ),
      
       floatingActionButton: SpeedDial(
          // both default to 16
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          // this is ignored if animatedIcon is non null
          // child: Icon(Icons.add),
         // visible: _dialVisible,
          // If true user is forced to close dial manually 
          // by tapping main button and overlay is not rendered.
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.add),
              onTap: () => _showConsumoFormView(),
            ),
            SpeedDialChild(
              child: Icon(Icons.monitor),
              onTap: () =>_showMonitoringFormView(),
            ),
            
          ],
        ),
      
    );
  }

  void _showConsumoFormView({Consumo consumo}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConsumoFormView(
                  consumo: consumo,
                )));
  }
  void _showMonitoringFormView({Consumo consumo}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MonitorFormView(
                  consumo: consumo,
                )));
  }
}



