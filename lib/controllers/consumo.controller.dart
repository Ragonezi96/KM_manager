import 'package:sql_lite/repositories/consumo.repository.dart';
import 'package:mobx/mobx.dart';
import 'package:sql_lite/models/consumo.model.dart';
import '../app_status.dart';
part 'consumo.controller.g.dart';

class ConsumoController = _ConsumoController with _$ConsumoController;

abstract class _ConsumoController with Store {
  ConsumoRepository repository;
  _ConsumoController() {
    _init();
  }
  Future<void> _init() async {
    repository = await ConsumoRepository.getInstance();
    await getAll();
  }

  @observable
  AppStatus status = AppStatus.none;
  @observable
  ObservableList<Consumo> list = ObservableList<Consumo>();
  @action
  Future<void> getAll() async {
    status = AppStatus.loading;
    try {
      if (repository != null) {
        final allList = await repository.getAll();
        list.clear();
        list.addAll(allList);
      }
      status = AppStatus.success;
    } catch (e) {
      status = AppStatus.error..value = e;
    }
  }
  @action
  Future<void> getKM() async {
    status = AppStatus.loading;
    try {
      if (repository != null) {
        final newList = await repository.getKM();
        list.clear();
        list.addAll(newList);
      }
      status = AppStatus.success;
    } catch (e) {
      status = AppStatus.error..value = e;
    }
  }

  @action
  Future<void> create(Consumo p) async {
    status = AppStatus.loading;
    try {
      await repository.create(p);
      await getAll();
      status = AppStatus.success;
    } catch (e) {
      status = AppStatus.error..value = e;
    }
  }

  @action
  Future<void> update(Consumo p) async {
    status = AppStatus.loading;
    try {
      await repository.update(p);
      await getAll();
      status = AppStatus.success;
    } catch (e) {
      status = AppStatus.error..value = e;
    }
  }

  @action
  Future<void> delete(int id) async {
    status = AppStatus.loading;
    try {
      await repository.delete(id);
      await getAll();
      status = AppStatus.success;
    } catch (e) {
      status = AppStatus.error..value = e;
    }
  }
}
