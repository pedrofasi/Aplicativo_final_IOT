import 'package:aplicativo_veiculo/Controllers/carros.controller.dart';
import 'package:aplicativo_veiculo/Controllers/registro.controller.dart';
import 'package:aplicativo_veiculo/Models/carros.model.dart';
import 'package:aplicativo_veiculo/Models/registro.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistroFormView3 extends StatefulWidget {

  final Registro registro;

  RegistroFormView3({this.registro});

  @override
  _RegistroFormViewState3 createState() => _RegistroFormViewState3();
}

class _RegistroFormViewState3 extends State<RegistroFormView3> {

  final _tChassi = TextEditingController();
  final _tPlaca = TextEditingController();
  final _tkmporlitro = TextEditingController();
  var _tqntdveiculos = 0;

  String _tNome, _tSenha, _tUsuario, _tCpf, _tCep,_tcodigo;

  var _formKey = GlobalKey<FormState>();
  Registro _registro;
  Carros _carro = Carros();
  @override

  void initState() {
    super.initState();

    _registro = widget.registro;
    _tNome = _registro.nome;
    _tSenha = _registro.senha;
    _tUsuario = _registro.usuario;
    _tCpf = _registro.cpf;
    _tCep = _registro.cep;
    _tcodigo = _registro.id.toString();
    _tqntdveiculos = _registro.qntdcarros;

    if(_tqntdveiculos == null){
      _tqntdveiculos = 0;
    }
  }


  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  // Widget EditText
  _editText(String field, TextEditingController controller, TextInputType type) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: type,

      decoration: InputDecoration(
        labelText: field,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final _controller = Provider.of<CarrosController>(context);
    final _controller2 = Provider.of<RegistroController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Informações Extras",style: TextStyle(color: Colors.green),),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(

          padding: EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                _editText("Placa do veículo", _tPlaca,TextInputType.text),
                _editText("Chassi do veículo", _tChassi,TextInputType.text),
                _editText("Quantos Km/L o veículo faz?", _tkmporlitro,TextInputType.number),
                Container(
                  margin: EdgeInsets.only(top: 5.0, bottom: 5),
                  height: 45,
                  child: RaisedButton(
                    color: Colors.green,
                    child: Text(
                      "Adicionar Veículo",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {

                        _carro.chassi = _tChassi.text;
                        _carro.placa = _tPlaca.text;
                        _carro.kmporlitro = _tkmporlitro.text;
                        _carro.codigofk = _tcodigo;
                        _carro.id = 0;

                        _controller.create(_carro);

                        _incrementCounter();

                        _registro.senha = _tSenha;
                        _registro.nome = _tNome;
                        _registro.usuario = _tUsuario;
                        _registro.cep = _tCep;
                        _registro.cpf = _tCpf;
                        _registro.qntdcarros = _tqntdveiculos;
                        _controller2.edit(_registro);

                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _incrementCounter() {
    setState(() {
      _tqntdveiculos++;
    });
  }

}
