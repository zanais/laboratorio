import 'package:flutter/material.dart';
import 'package:laboratorio/agregar_nuevo.dart';
import 'package:laboratorio/default.dart';
//import 'package:laboratorio/main.dart';
import 'package:url_launcher/url_launcher.dart';

class RealizarLlamadas extends StatefulWidget {
  int _numero;
  RealizarLlamadas(this._numero);
  @override
  _RealizarLlamadasState createState() {
    return _RealizarLlamadasState(this._numero);
  }
  // => _RealizarLlamadasState();
}

class _RealizarLlamadasState extends State<RealizarLlamadas> {
  int numero;
  _RealizarLlamadasState(this.numero);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: new Icon(
                    Icons.home,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Default(numero)));
                  },
                ),
                Text(
                  'Realizar llamada',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                        icon: new Icon(Icons.call),
                        onPressed: () {
                          launch("tel://911");
                        }),
                    Text('911'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                        icon: new Icon(Icons.call),
                        onPressed: () {
                          launch("tel://+52 81 1846 4778");
                        }),
                    Text('Hijo'),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                        icon: new Icon(Icons.call),
                        onPressed: () {
                          launch("tel://+52 1 81 2617 6262");
                        }),
                    Text('Hijo'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                        icon: new Icon(Icons.call),
                        onPressed: () {
                          launch("tel://+52 1 81 1695 9821");
                        }),
                    Text('EMME'),
                  ],
                )
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AgregarNuevoContacto(numero),
                    ));
              },
              child: Text(
                'Agregar numero telefonico',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
