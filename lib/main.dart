import 'package:aplicativo_veiculo/Controllers/carros.controller.dart';
import 'package:aplicativo_veiculo/Models/carros.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Controllers/registro.controller.dart';
import 'Views/registro_1login.view.dart';



void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[
          Provider<RegistroController>.value(
            value: RegistroController(),),
          Provider<CarrosController>.value(
            value: CarrosController(),)
        ],
        child: MaterialApp(
          title: 'Veiculo App',
          debugShowCheckedModeBanner: false,
          home: RegistroListView(),
        )
    );
  }
}
