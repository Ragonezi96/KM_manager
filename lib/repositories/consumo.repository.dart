import 'package:sql_lite/models/consumo.model.dart';
import 'package:sql_lite/repositories/consumo.dao.dart';
import 'package:sql_lite/repositories/consumo.database.dart';

class ConsumoRepository {
  static ConsumoRepository _instance;
  ConsumoRepository._();
  AppDatabase database;
  ConsumoDao consumoDao;
  static Future<ConsumoRepository> getInstance() async {
    if (_instance != null) return _instance;
    _instance = ConsumoRepository._();
    await _instance.init();
    return _instance;
  }

  Future<void> init() async {
    database = await $FloorAppDatabase.databaseBuilder('consumo.db').build();
    consumoDao = database.consumoDao;
  }

  Future<List<Consumo>> getAll() async {
    try {
      return await consumoDao.getAll();
    } catch (e) {
      return List<Consumo>();
    }
  }
  Future<List<Consumo>> getKM() async {
    try {
      return await consumoDao.getKM();
    } catch (e) {
      return List<Consumo>();
    }
  }

  Future<bool> create(Consumo p) async {
    try {
      await consumoDao.insertConsumo(p);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> update(Consumo p) async {
    try {
      await consumoDao.updateConsumo(p);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(int id) async {
    try {
      Consumo p = await consumoDao.getConsumoById(id);
      await consumoDao.deleteConsumo(p);
      return true;
    } catch (e) {
      return false;
    }
  }
}
