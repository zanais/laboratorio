import 'package:flutter/material.dart';
import 'package:laboratorio/listaChats.dart';
import 'package:laboratorio/realizar_llamadas.dart';
import 'package:firebase_database/firebase_database.dart';

class Default extends StatefulWidget {
  int _numero;
  Default(this._numero);
  @override
  _DefaultState createState() {
    return _DefaultState(this._numero);
  }
  // => _DefaultState();
}

class _DefaultState extends State<Default> {
  int numero;
  String keyUsuario;
  _DefaultState(this.numero);

  @override
  void initState() {
    super.initState();
    getUsuariosTotales();
  }

  void getUsuariosTotales() {
    usuariosReferences.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> getMapPrductos = snapshot.value;
      getMapPrductos.forEach((key, value) {
        Map<dynamic, dynamic> f = value;
        var numeroVerificar = f["numero"];
        if (numeroVerificar == numero) {
          keyUsuario = key;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Easy Help'),
            IconButton(
              icon: new Icon(Icons.call),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RealizarLlamadas(numero)));
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RealizarLlamadas(numero)));
              },
              child: Text('Telefono'),
            ),
            IconButton(
              icon: new Icon(Icons.message),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListaChats(numero, keyUsuario)));
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListaChats(numero, keyUsuario)));
              },
              child: Text('Mensajes'),
            )
          ],
        ),
      ),
    );
  }
}
