import 'package:flutter/material.dart';
import 'package:laboratorio/chats.dart';
import 'package:laboratorio/default.dart';
import 'package:laboratorio/models/UsuarioLiga.dart';
import 'package:firebase_database/firebase_database.dart';
import 'main.dart';

List<UsuarioLiga> lstUsuariosLiga = [];
final usuariosReferences =
    FirebaseDatabase.instance.reference().child('Usuarios');

class ListaChats extends StatefulWidget {
  int _numero;
  String keyUsuario;
  ListaChats(this._numero, this.keyUsuario);
  @override
  _ListaChatsState createState() {
    return _ListaChatsState(this._numero, this.keyUsuario);
  }
  // => _ListaChatsState();
}

class _ListaChatsState extends State<ListaChats> {
  int _numero;
  String keyUsuario;
  _ListaChatsState(this._numero, this.keyUsuario);
  @override
  void initState() {
    super.initState();
    getUsuariosAgregados();
  }

  void getUsuariosAgregados() {
    lstUsuariosLiga = [];
    usuariosReferences
        .child(keyUsuario)
        .child('UsuarioLiga')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> getMapPrductos = snapshot.value;
      getMapPrductos.forEach((key, value) {
        Map<dynamic, dynamic> f = value;
        UsuarioLiga usuarioLigado = UsuarioLiga("", "", 0);
        var s = f["Precio"];
        usuarioLigado.idUsuario = key;
        usuarioLigado.nombre = f["nombre"];
        usuarioLigado.numero = f["numero"];
        setState(() {
          lstUsuariosLiga.add(usuarioLigado);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: new Icon(Icons.home),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Default(_numero)));
                    },
                  ),
                  Text('Mensajes'),
                ],
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                            itemCount: lstUsuariosLiga.length,
                            itemBuilder: (context, index) {
                              return Contactos(
                                  "${lstUsuariosLiga[index].nombre}",
                                  "${lstUsuariosLiga[index].nombre.substring(0, 1)}",
                                  _numero,
                                  keyUsuario,
                                  lstUsuariosLiga[index].numero);
                              // Padding(
                              //   padding: const EdgeInsets.all(8.15),
                              //   child: Card(
                              //     color: Colors.deepPurpleAccent,
                              //     child: Column(
                              //       children: [
                              //         Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceEvenly,
                              //           children: <Widget>[
                              //             CircleAvatar(
                              //               child: Text(
                              //                   "${lstUsuariosLiga[index].nombre.substring(0, 1)}"),
                              //               maxRadius: 25.0,
                              //             ),
                              //             Text(
                              //               "${lstUsuariosLiga[index].nombre}",
                              //               textAlign: TextAlign.center,
                              //             ),
                              //             // Text(
                              //             //   "\$:  ${lstCemento[index].precio}",
                              //             //   textAlign: TextAlign.center,
                              //             // ),
                              //           ],
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // );
                            }),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Contactos extends StatelessWidget {
  Contactos(
      this.nombre, this.iniciales, this._numero, this.keyUsuario, this.para);
  String nombre;
  String iniciales;
  int _numero;
  String keyUsuario;
  int para;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                child: Text(
                  "$iniciales",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                backgroundColor: Colors.blueGrey,
                maxRadius: 30.0,
              )
            ],
          ),
        ),
        Container(
          // color: Colors.blueGrey,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)), //here
              color: Colors.blueGrey),
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Chats(_numero, keyUsuario, para)));
                  },
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "19/04/2021",
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.white),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "$nombre",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
