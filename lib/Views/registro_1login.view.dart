
import 'package:aplicativo_veiculo/Controllers/registro.controller.dart';
import 'package:aplicativo_veiculo/Models/registro.model.dart';
import 'package:aplicativo_veiculo/Views/registro_0cadastro.view.dart';
import 'package:aplicativo_veiculo/Views/registro_2login_efetuado.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../app_status.dart';

class RegistroListView extends StatefulWidget {
  @override
  _RegistroListViewState createState() => _RegistroListViewState();
}

class _RegistroListViewState extends State<RegistroListView> {

  final _tUsuario = TextEditingController();
  final _tSenha = TextEditingController();
  var _infoText = "Dados incorretos"
      "\nJá possui cadastro?";
  var _formKey1 = GlobalKey<FormState>();
  bool _isValidar = false;
  Registro _registro;

  @override
  Widget build(BuildContext context) {

    final _controller = Provider.of<RegistroController>(context);

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

        obscureText: controller == _tSenha ? true : false,
        decoration: InputDecoration(
          labelText: field,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("IoTeam - VeiculoAPP",style: TextStyle(color: Colors.blue),),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.blueGrey,
        onRefresh: () async {
          await _controller.getAll();
        },
        child: Container(

          child: Observer(builder: (_) {
            if (_controller.status == AppStatus.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (_controller.status == AppStatus.success) {
              return Form(
                key: _formKey1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.network('https://images.vexels.com/media/users/3/155352/isolated/preview/dbb8d1d79c671244a595f04c51632049-silhueta-de-vista-lateral-do-carro-sedan-by-vexels.png',height: 300,fit: BoxFit.fill,),

                    _editText("Usuario", _tUsuario,TextInputType.text),
                    _editText("Senha", _tSenha,TextInputType.visiblePassword),

                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 20),
                      padding: EdgeInsets.only(left: 20, right:20),
                      height: 45,
                      child: RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue)
                        ),
                        elevation: 5,
                        child: Text(
                          "Entrar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey1.currentState.validate()) {
                            for(int i = 0 ; i < _controller.list.length ; i++){
                              if(_tUsuario.text == _controller.list[i].usuario){
                                if(_tSenha.text == _controller.list[i].senha){
                                  setState(() {
                                    _isValidar = false;
                                  });
                                  _showRegistroFormView1(registro: _controller.list[i]);
                                  break;
                                }
                                else{
                                  setState(() {
                                    _isValidar = true;
                                  });
                                }
                              }
                              else{
                                setState(() {
                                  _isValidar = true;
                                });
                              }
                            }
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 10),
                      height: 45,
                      padding: EdgeInsets.only(left: 20, right:20),

                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.orange)
                        ),
                        elevation: 5,
                        color: Colors.orange,
                        child: Text(
                          "Cadastro",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistroFormView(registro: null),
                            ),
                          );
                        },
                      ),
                    ),
                    if(_isValidar)
                      _textInfo()
                  ],
                ),
              );
            } else {
              return Text("${_controller.status.value}");
            }
          }),
        ),
      ),
    );
  }

  void _showRegistroFormView1({Registro registro}) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => RegistroFormView1(registro: registro,))
    );
  }

// // Widget text
  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.red, fontSize: 20.0),
    );
  }

}

