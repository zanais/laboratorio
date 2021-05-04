import 'package:firebase_database/firebase_database.dart';

class Mensajes {
  String idMensaje;
  int numeroRemitente;
  String mensaje;
  int numeroDestinatario;
  bool logeado;
  DateTime fecha;

  Mensajes(this.idMensaje, this.numeroRemitente, this.mensaje,
      this.numeroDestinatario, this.logeado, this.fecha);

  Mensajes.fromSnapshot(DataSnapshot snapshot) {
    idMensaje = snapshot.key;
    numeroRemitente = snapshot.value['numero'];
    numeroDestinatario = snapshot.value['para'];
    mensaje = snapshot.value['mensaje'];
    fecha = snapshot.value['fecha'];
  }
}
