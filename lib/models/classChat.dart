import 'package:firebase_database/firebase_database.dart';

class ModelChat {
  String keyMensaje;
  DateTime fecha;
  String mensaje;
  int numeroEnvia;
  int numeroRecibe;

  ModelChat(this.keyMensaje, this.fecha, this.mensaje, this.numeroEnvia,
      this.numeroRecibe);

  ModelChat.fromSnapshot(DataSnapshot snapshot) {
    keyMensaje = snapshot.key;
    fecha = snapshot.value['fecha'];
    mensaje = snapshot.value['mensaje'];
    numeroEnvia = snapshot.value['numero'];
    numeroRecibe = snapshot.value['para'];
  }
}
