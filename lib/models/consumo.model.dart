import 'package:floor/floor.dart';


@entity
class Consumo {
  @PrimaryKey(autoGenerate: true)
  int id;
  double valorcombustivel;
  int kmatual;
  double litrosabastecidos;
  String date;
  bool concluido;
  Consumo(
      {this.id, this.valorcombustivel, this.litrosabastecidos, this.kmatual, this.date, this.concluido});
  Consumo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    valorcombustivel = json['valorcombustivel'];
    litrosabastecidos = json['litrosabastecidos'];
    kmatual = json['kmatual'];

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['valorcombustivel'] = this.valorcombustivel;
    data['litrosabastecidos'] = this.litrosabastecidos;
    data['kmatual'] = this.kmatual;
    data['concluido'] = this.concluido;
    return data;
  }
}
