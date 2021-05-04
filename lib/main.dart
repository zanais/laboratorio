import 'package:flutter/material.dart';
import 'package:laboratorio/const.dart';
import 'package:laboratorio/default.dart';
//import 'package:laboratorio/listaChats.dart';
import 'package:laboratorio/models/usuarios.dart';
//import 'package:laboratorio/realizar_llamadas.dart';
//import 'realizar_llamadas.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// final _firestore = FirebaseFirestore.instance.collection('Usuarios');
final usuariosReferences =
    FirebaseDatabase.instance.reference().child('Usuarios');

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int numero;
  List<Usuarios> lstUsuarios = [];
  @override
  void initState() {
    super.initState();
    getUsuariosTotales();
  }

  void getUsuariosTotales() {
    lstUsuarios = [];
    usuariosReferences.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> getMapPrductos = snapshot.value;
      getMapPrductos.forEach((key, value) {
        Map<dynamic, dynamic> f = value;
        Usuarios usuario = Usuarios("", 0);

        usuario.idUsuario = key;
        usuario.numero = f["numero"];

        lstUsuarios.add(usuario);
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
            TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  numero = int.parse(value);
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Numero')),
            TextButton(
              onPressed: () {
                var existe = lstUsuarios
                    .where((element) => element.numero == numero)
                    .any((element) => true);
                if (existe) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Default(numero)));
                } else {
                  usuariosReferences.push().set({'numero': numero}).then((_) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Default(numero)));
                  }).catchError((e) {
                    print(e);
                  });
                }
              },
              child: Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
