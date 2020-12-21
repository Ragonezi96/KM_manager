// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumo.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConsumoController on _ConsumoController, Store {
  final _$statusAtom = Atom(name: '_ConsumoController.status');

  @override
  AppStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(AppStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$listAtom = Atom(name: '_ConsumoController.list');

  @override
  ObservableList<Consumo> get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(ObservableList<Consumo> value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  final _$getAllAsyncAction = AsyncAction('_ConsumoController.getAll');

  @override
  Future<void> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$getKMAsyncAction = AsyncAction('_ConsumoController.getKM');

  @override
  Future<void> getKM() {
    return _$getKMAsyncAction.run(() => super.getKM());
  }

  final _$createAsyncAction = AsyncAction('_ConsumoController.create');

  @override
  Future<void> create(Consumo p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('_ConsumoController.update');

  @override
  Future<void> update(Consumo p) {
    return _$updateAsyncAction.run(() => super.update(p));
  }

  final _$deleteAsyncAction = AsyncAction('_ConsumoController.delete');

  @override
  Future<void> delete(int id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }

  @override
  String toString() {
    return '''
status: ${status},
list: ${list}
    ''';
  }
}
