
import 'package:aplicativo_veiculo/Models/carros.model.dart';
import 'package:aplicativo_veiculo/Repositories/carros.repository.dart';
import 'package:mobx/mobx.dart';
import '../app_status.dart';

part 'carros.controller.g.dart';

class CarrosController = _CarrosController with _$CarrosController;

abstract class _CarrosController with Store{

  CarrosRepository repository;

  _CarrosController(){
    repository = new CarrosRepository();
    _init();
  }

  _init() async {
    getAll();
  }

  @observable
  AppStatus status = AppStatus.none;

  @observable
  ObservableList<Carros> list = ObservableList<Carros>();

  @action
  Future<void> getAll() async {
    status = AppStatus.loading;
    try {
      final allList = await repository.getAll();
      list.clear();
      list.addAll(allList);
      status = AppStatus.success;
    }catch(e){
      status = AppStatus.error..value = e;
    }
  }

  @action
  Future<void> create(Carros carros) async {
    status = AppStatus.loading;
    try {
      bool isCreated = await repository.create(carros);
      if(isCreated) {
        getAll();
        status = AppStatus.success;
      }
      else
        status = AppStatus.error..value = "Erro ao tentar adicionar veiculo!";
    }catch(e){
      status = AppStatus.error..value = e;
    }
  }

  @action
  Future<void> edit(Carros carros) async {
    status = AppStatus.loading;
    try {
      bool isEdited = await repository.edit(carros);
      if(isEdited) {
        getAll();
        status = AppStatus.success;
      }
      else
        status = AppStatus.error..value = "Erro ao tentar alterar veiculo!";
    }catch(e){
      status = AppStatus.error..value = e;
    }
  }

  @action
  Future<void> delete(int id) async {
    status = AppStatus.loading;
    try {
      bool isDeleted = await repository.delete(id);
      if(isDeleted) {
        getAll();
        status = AppStatus.success;
      }
      else
        status = AppStatus.error..value = "Erro ao tentar remover o veiculo!";
    }catch(e){
      status = AppStatus.error..value = e;
    }
  }

}