// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carros.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CarrosController on _CarrosController, Store {
  final _$statusAtom = Atom(name: '_CarrosController.status');

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

  final _$listAtom = Atom(name: '_CarrosController.list');

  @override
  ObservableList<Carros> get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(ObservableList<Carros> value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  final _$getAllAsyncAction = AsyncAction('_CarrosController.getAll');

  @override
  Future<void> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction = AsyncAction('_CarrosController.create');

  @override
  Future<void> create(Carros carros) {
    return _$createAsyncAction.run(() => super.create(carros));
  }

  final _$editAsyncAction = AsyncAction('_CarrosController.edit');

  @override
  Future<void> edit(Carros carros) {
    return _$editAsyncAction.run(() => super.edit(carros));
  }

  final _$deleteAsyncAction = AsyncAction('_CarrosController.delete');

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
