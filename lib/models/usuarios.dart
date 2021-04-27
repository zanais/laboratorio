import 'package:firebase_database/firebase_database.dart';

class Usuarios {
  String idUsuario;
  int numero;

  Usuarios(this.idUsuario, this.numero);

  Usuarios.fromSnapshot(DataSnapshot snapshot) {
    idUsuario = snapshot.key;
    numero = snapshot.value['numero'];
  }
}
