import 'package:sql_lite/models/consumo.model.dart';
import 'package:floor/floor.dart';

@dao
abstract class ConsumoDao {
  @Query('SELECT * FROM Consumo order by date, valorcombustivel')
  Future<List<Consumo>> getAll();

  @Query("SELECT * from Consumo where id = :id")
  Future<Consumo> getConsumoById(int id);

  @Query('SELECT * FROM Consumo order by  kmatual')
  Future<List<Consumo>>getKM();

  @Query("SELECT SUM(litrosabastecidos)- (SELECT litrosabastecidos FROM Consumo WHERE id = (SELECT MAX(id) FROM Consumo ))  from Consumo ")
  Future<List<Consumo>> getLiters();

  @insert
  Future<int> insertConsumo(Consumo p);
  @update
  Future<int> updateConsumo(Consumo p);
  @delete
  Future<int> deleteConsumo(Consumo p);
}
