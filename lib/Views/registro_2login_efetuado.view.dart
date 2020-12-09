import 'package:aplicativo_veiculo/Controllers/carros.controller.dart';
import 'package:aplicativo_veiculo/Models/carros.model.dart';
import 'package:aplicativo_veiculo/Models/registro.model.dart';
import 'package:aplicativo_veiculo/Views/registro_3adicionar_veiculo.view.dart';
import 'package:aplicativo_veiculo/Views/registro_4adicionar_info_pessoa.view.dart';
import 'package:aplicativo_veiculo/Views/registro_5vercarros.view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../app_status.dart';

class RegistroFormView1 extends StatefulWidget {

  final Registro registro;

  RegistroFormView1({this.registro});

  @override
  _RegistroFormViewState1 createState() => _RegistroFormViewState1();
}

class _RegistroFormViewState1 extends State<RegistroFormView1> {

  String _tNome, _tSenha,_tUsuario,_tId;
  int _tqntdcarros;
  Registro _registro;
  Carros _carro = Carros();

  @override
  void initState() {
    super.initState();

    _registro = widget.registro;
    _tUsuario = _registro.usuario;
    _tNome = _registro.nome;
    _tSenha = _registro.senha;
    _tId = _registro.id.toString();
    _tqntdcarros = _registro.qntdcarros;
  }

  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<CarrosController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard" ,style: TextStyle(color: Colors.grey),),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                _showRegistroFormView2(registro: _registro);
              },
              child: Icon(
                Icons.add
              ),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _controller.getAll();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 0, bottom: 0),
              height: 500,
              child: Observer(builder: (_) {
                if (_controller.status == AppStatus.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (_controller.status == AppStatus.success) {
                  return ListView(
                    children: [
                      for (int i = 0; i < _controller.list.length; i++)
                        if(_controller.list[i].codigofk == _tId)
                        ListTile(
                              title:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text(_controller.list[i].chassi,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.grey),),
                                    Text(
                                      _controller.list[i].placa, style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.grey),),
                                  ],
                                ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CarrosFormView(carro: _controller.list[i], registro: _registro,),
                                  ),
                                );
                              }
                         ),
                    ],
                  );
                } else {
                  return Text("${_controller.status.value}");
                }
              }
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              height: 45,
              padding: EdgeInsets.only(left: 20, right:20),

              child: RaisedButton(
                color: Colors.green,
                child: Text(
                  "Adicionar veículo!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                onPressed: () {
                  _showRegistroFormView3(registro: _registro);
                },
              ),
            ),
            if(_tqntdcarros == null || _tqntdcarros == 0)
              _textInfo(),
          ],
        ),
      ),
    );



  }
  void _showRegistroFormView2({Registro registro}) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => RegistroFormView2(registro: registro,))
    );
  }

  void _showRegistroFormView3({Registro registro}) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => RegistroFormView3(registro: registro,))
    );
  }

  _saved(Carros carro){
      if(_tId == carro.codigofk){
        return true;
      }
      else{
        return false;
      }
  }

  _textInfo() {
    return Text(
      'Você ainda não possui veículos cadastrados',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.red, fontSize: 16.0),
    );
  }

  _textInfo1() {
    return Text(
      'Carros registrados:',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.blue, fontSize: 16.0),
    );
  }

}