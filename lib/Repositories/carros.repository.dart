import 'dart:convert';
import 'package:aplicativo_veiculo/Models/carros.model.dart';
import 'package:http/http.dart' as http;

class CarrosRepository{

  var url = 'http://pedrofasi-001-site1.btempurl.com/api/carros';

  Future<List<Carros>> getAll() async{

    final response = await http.get(url);

    if(response.statusCode == 200){

      List<Carros> data = (json.decode(response.body) as List)
          .map((i) => Carros.fromJson(i)).toList();

      return data;
    }else{
      throw Exception("Erro de conexão com o servidor!");
    }
  }

  Future<bool> create(Carros carros) async{

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:  jsonEncode(carros.toJson()),
    );

    if(response.statusCode == 201){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> edit(Carros professor) async{

    final response = await http.put(
      url + "/${professor.id}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(professor.toJson()),
    );

    if(response.statusCode == 204){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> delete(int id) async{

    final response = await http.delete( url + "/${id}");

    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

}