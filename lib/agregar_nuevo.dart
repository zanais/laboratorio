import 'package:flutter/material.dart';
import 'package:laboratorio/main.dart';

class AgregarNuevoContacto extends StatefulWidget {
  @override
  _AgregarNuevoContactoState createState() => _AgregarNuevoContactoState();
}

class _AgregarNuevoContactoState extends State<AgregarNuevoContacto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: new Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                ),
                Text('Agregar Contacto'),
              ],
            ),
            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(20),
                icon: Icon(Icons.person),
              ),
            ),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Numero',
                contentPadding: EdgeInsets.all(20),
                icon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),
            TextButton(
              onPressed: null,
              child: Text('Añadir contacto'),
            ),
          ],
        ),
      ),
    );
  }
}
