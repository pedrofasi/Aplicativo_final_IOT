
import 'package:aplicativo_veiculo/Controllers/carros.controller.dart';
import 'package:aplicativo_veiculo/Controllers/registro.controller.dart';
import 'package:aplicativo_veiculo/Models/carros.model.dart';
import 'package:aplicativo_veiculo/Models/registro.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarrosFormView extends StatefulWidget {

  final Carros carro;
  final Registro registro;

  CarrosFormView({this.carro,this.registro});

  @override
  _CarrosFormViewState createState() => _CarrosFormViewState();
}

class _CarrosFormViewState extends State<CarrosFormView> {

  final _tPlaca = TextEditingController();
  final _tChassi = TextEditingController();
  final _tkmporlitro = TextEditingController();
  var _tqntdveiculos = 0;

  String _tNome, _tSenha, _tUsuario, _tCpf, _tCep,_tcodigo;

  var _formKey = GlobalKey<FormState>();

  bool _isEdited = false;
  Carros _carro;
  Registro _registro;

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

    if (widget.carro == null) {
      _carro = Carros();
      _isEdited = false;
    } else {
      _carro = widget.carro;
      _isEdited = true;
      _tPlaca.text = _carro.placa;
      _tChassi.text = _carro.chassi;
      _tkmporlitro.text =  _carro.kmporlitro;
      _tcodigo = _carro.codigofk;
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
        title: Text("Veículo"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _editText("Placa", _tPlaca,TextInputType.text),
                _editText("Chassi", _tChassi,TextInputType.text),
                _editText("Km/L", _tkmporlitro,TextInputType.number),
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 20),
                  height: 45,
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      "Salvar alterações",
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

                        _controller.edit(_carro);

                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0, bottom: 5),
                    height: 45,
                    child: RaisedButton(
                      color: Colors.red,
                      child: Text(
                        "Remover veículo",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()){

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: new Text("Exclusão de Veículo"),
                                content: new Text("Tem certeza que deseja excluir este veiculo?"),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  FlatButton(
                                    child: new Text("Cancelar"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: new Text("Excluir"),
                                    onPressed: () {
                                      _controller.delete(_carro.id);

                                      _decrementCounter();

                                      _registro.senha = _tSenha;
                                      _registro.nome = _tNome;
                                      _registro.usuario = _tUsuario;
                                      _registro.cep = _tCep;
                                      _registro.cpf = _tCpf;
                                      _registro.qntdcarros = _tqntdveiculos;
                                      _controller2.edit(_registro);

                                      Navigator.of(context).pop();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );

                        }
                      },
                    ),
                  ),
              ],
            ),
          )),
    );
  }

  void _decrementCounter() {
    setState(() {
      _tqntdveiculos--;
    });
  }

}