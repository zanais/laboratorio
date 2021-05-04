import 'package:flutter/material.dart';
import 'package:laboratorio/default.dart';
//import 'package:laboratorio/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:laboratorio/models/usuarios.dart';

final usuariosReferences =
    FirebaseDatabase.instance.reference().child('Usuarios');
final usuariosLigaReference = usuariosReferences.child('UsuariosLiga');

class AgregarNuevoContacto extends StatefulWidget {
  int _numero;
  AgregarNuevoContacto(this._numero);
  @override
  _AgregarNuevoContactoState createState() {
    return _AgregarNuevoContactoState(this._numero);
  }
  //  => _AgregarNuevoContactoState();
}

class _AgregarNuevoContactoState extends State<AgregarNuevoContacto> {
  int numero;
  Usuarios usuario;
  String nombre;
  String keyUsuario;
  int numeroGuardar;
  _AgregarNuevoContactoState(this.numero);
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
        if (numeroVerificar == numero) {}
        keyUsuario = key;
      });
    });
  }

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
                  'Agregar Contacto',
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
            TextField(
              keyboardType: TextInputType.name,
              onChanged: (value) {
                nombre = value;
              },
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(20),
                icon: Icon(Icons.person),
              ),
            ),
            TextField(
              onChanged: (value) {
                numeroGuardar = int.parse(value);
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Numero',
                contentPadding: EdgeInsets.all(20),
                icon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                usuariosReferences
                    .child(keyUsuario)
                    .child('UsuarioLiga')
                    .push()
                    .set({'numero': numeroGuardar, 'nombre': nombre}).then((_) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Agregado Correctamente"),
                          actions: [
                            TextButton(
                                child: Text("Aceptar"),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Default(numero)));
                                }),
                          ],
                        );
                      });
                }).catchError((e) {
                  print(e);
                });
              },
              child: Text('Añadir contacto',
                  style: TextStyle(
                    color: Colors.black,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
