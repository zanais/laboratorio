import 'package:flutter/material.dart';
import 'package:laboratorio/agregar_nuevo.dart';
import 'package:laboratorio/main.dart';
import 'package:url_launcher/url_launcher.dart';

class RealizarLlamadas extends StatefulWidget {
  @override
  _RealizarLlamadasState createState() => _RealizarLlamadasState();
}

class _RealizarLlamadasState extends State<RealizarLlamadas> {
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
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: new Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                ),
                Text('Realizar llamada'),
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
                          launch("tel://+8183212486");
                        }),
                    Text('EMME'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(icon: new Icon(Icons.call), onPressed: null),
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
                    IconButton(icon: new Icon(Icons.call), onPressed: null),
                    Text('Hijo'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(icon: new Icon(Icons.call), onPressed: null),
                    Text('Emergencias'),
                  ],
                )
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AgregarNuevoContacto(),
                    ));
              },
              child: Text('Agregar numero telefonico'),
            ),
          ],
        ),
      ),
    );
  }
}
