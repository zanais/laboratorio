import 'package:firebase_database/firebase_database.dart';

class UsuarioLiga {
  String idUsuario;
  int numero;
  String nombre;

  UsuarioLiga(
    this.idUsuario,
    this.nombre,
    this.numero,
  );

  UsuarioLiga.fromSnapshot(DataSnapshot snapshot) {
    idUsuario = snapshot.key;
    numero = snapshot.value['numero'];
  }
}
