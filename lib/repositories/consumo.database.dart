import 'dart:async';
import 'package:sql_lite/models/consumo.model.dart';
import 'package:sql_lite/repositories/consumo.dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'consumo.database.g.dart';

@Database(version: 1, entities: [Consumo])
abstract class AppDatabase extends FloorDatabase {
  ConsumoDao get consumoDao;
}
