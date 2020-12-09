
import 'package:aplicativo_veiculo/Controllers/registro.controller.dart';
import 'package:aplicativo_veiculo/Models/registro.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistroFormView2 extends StatefulWidget {

  final Registro registro;

  RegistroFormView2({this.registro});

  @override
  _RegistroFormViewState2 createState() => _RegistroFormViewState2();
}

class _RegistroFormViewState2 extends State<RegistroFormView2> {

  final _tcpf = TextEditingController();
  final _tcep = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  String _tUsuario, _tSenha , _tNome;
  int _tqntdCarros;
  Registro _registro;

  @override
  void initState() {
    super.initState();

    _registro = widget.registro;
    _tUsuario = _registro.usuario;
    _tSenha = _registro.senha;
    _tNome = _registro.nome;
    _tqntdCarros = _registro.qntdcarros;
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

    final _controller = Provider.of<RegistroController>(context);

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
                _editText("CPF", _tcpf,TextInputType.number),
                _editText("CEP", _tcep,TextInputType.number),
                  Container(
                    margin: EdgeInsets.only(top: 5.0, bottom: 5),
                    height: 45,
                    child: RaisedButton(
                      color: Colors.green,
                      child: Text(
                        "Atualizar!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {

                          _registro.usuario = _tUsuario;
                          _registro.senha = _tSenha;
                          _registro.nome = _tNome;
                          _registro.cep = _tcep.text;
                          _registro.cpf = _tcpf.text;
                          _registro.qntdcarros = _tqntdCarros;
                          _controller.edit(_registro);
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

}
