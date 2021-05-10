import 'package:flutter/material.dart';
import 'package:laboratorio/default.dart';
//import 'package:chat_list/chat_list.dart';
import 'package:laboratorio/models/UsuarioLiga.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:laboratorio/models/classChat.dart';
import 'const.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<UsuarioLiga> lstUsuariosLiga = [];
List<ModelChat> lstMensajes = [];
final mensajesReference =
    FirebaseDatabase.instance.reference().child("Mensajes");

class Chats extends StatefulWidget {
  int _numero;
  String keyUsuario;
  int para;

  Chats(this._numero, this.keyUsuario, this.para);
  @override
  _ChatsState createState() {
    return _ChatsState(this._numero, this.keyUsuario, this.para);
  }
  // => _ChatsState();
}

class _ChatsState extends State<Chats> {
  String mensaje;
  int _numero;
  String keyUsuario;
  int para;
  final messageTextController = TextEditingController();
  _ChatsState(this._numero, this.keyUsuario, this.para);
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
      appBar: AppBar(
        title: Text('Mensajes'),
        leading: IconButton(
          icon: new Icon(Icons.home),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Default(_numero)));
          },
        ),
      ),
      backgroundColor: Colors.blue[300],
      // body: SafeArea(
      //   child: Column(
      //     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: <Widget>[
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         //crossAxisAlignment: CrossAxisAlignment.center,
      //         children: <Widget>[
      //           IconButton(
      //             icon: new Icon(Icons.home),
      //             onPressed: () {
      //               Navigator.push(context,
      //                   MaterialPageRoute(builder: (context) => MyHomePage()));
      //             },
      //           ),
      //           Text('Mensajes'),
      //         ],
      //       ),
      //       Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: <Widget>[
      //           SafeArea(
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               crossAxisAlignment: CrossAxisAlignment.stretch,
      //               children: <Widget>[
      //                 MessagesStream(_numero, para),
      //                 // MessageBubble(
      //                 //     sender: "Marcos", text: "Hola", logedUser: false),
      //                 // MessageBubble(
      //                 //     sender: "Pedro", text: "Hola", logedUser: true),
      //                 // MessageBubble(
      //                 //     sender: "Marcos",
      //                 //     text: "Como estas",
      //                 //     logedUser: false),
      //                 Container(
      //                   decoration: kMessageContainerDecoration,
      //                   child: Row(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     children: <Widget>[
      //                       Expanded(
      //                         child: TextField(
      //                           // controller: messageTextController,
      //                           onChanged: (value) {
      //                             mensaje = value;
      //                           },
      //                           decoration: kMessageTextFieldDecoration,
      //                         ),
      //                       ),
      //                       TextButton(
      //                         onPressed: () {
      //                           DateTime now = new DateTime.now();
      //                           DateTime date = new DateTime(
      //                               now.year,
      //                               now.month,
      //                               now.day,
      //                               now.hour,
      //                               now.minute,
      //                               now.second);
      //                           mensajesReference
      //                               .push()
      //                               .set({
      //                                 'numero': _numero,
      //                                 'mensaje': mensaje,
      //                                 'para': para,
      //                                 'fecha': date.toString()
      //                               })
      //                               .then((_) {})
      //                               .onError((error, stackTrace) {
      //                                 print(error);
      //                               });
      //                         },
      //                         child: Text(
      //                           'Enviar',
      //                           style: kSendButtonTextStyle,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       )
      //     ],
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(_numero, para),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        mensaje = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      DateTime now = new DateTime.now();
                      DateTime date = new DateTime(now.year, now.month, now.day,
                          now.hour, now.minute, now.second);
                      mensajesReference
                          .push()
                          .set({
                            'numero': _numero,
                            'mensaje': mensaje,
                            'para': para,
                            'fecha': date.toString()
                          })
                          .then((_) {})
                          .onError((error, stackTrace) {
                            print(error);
                          });
                    },
                    child: Text(
                      'Enviar',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class MessagesStream extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView(
//         reverse: true,
//         padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//         children: <Widget>[
//           MessageBubble(sender: "Marcos", text: "Hola", logedUser: false),
//         ],
//       ),
//     );
//   }
// }

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.logedUser});
  final String text;
  final String sender;
  final bool logedUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            logedUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
          Material(
            borderRadius: logedUser
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: logedUser ? Colors.lightBlueAccent : Colors.greenAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Text(
                '$text',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  final numeroLoged;
  final mensajePara;
  MessagesStream(this.numeroLoged, this.mensajePara);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: mensajesReference.onValue,
      // _firestore.collection('message').orderBy('timestamp').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        List<MessageBubble> messageWidgets = [];
        lstMensajes = [];
        if (snapshot.hasData) {
          final messages = snapshot.data;
          print(messages.snapshot.value);
          if (messages.snapshot.value != null) {
            Map<dynamic, dynamic> getMapPrductos = messages.snapshot.value;
            getMapPrductos.forEach((key, value) {
              ModelChat modelMensaje = ModelChat("", DateTime.now(), "", 0, 0);
              Map<dynamic, dynamic> f = value;
              final messsageText = f['mensaje'];
              final messageRemitente = f['numero'].toString();
              final messageDestinatario = f['para'];
              final fechaEnvio = f['fecha'];
              if ((mensajePara == messageDestinatario &&
                      numeroLoged == int.parse(messageRemitente)) ||
                  (numeroLoged == messageDestinatario &&
                      mensajePara == int.parse(messageRemitente))) {
                // print(messageDestinatario);
                modelMensaje.keyMensaje = key;
                modelMensaje.fecha = DateTime.parse(fechaEnvio);
                modelMensaje.mensaje = messsageText;
                modelMensaje.numeroEnvia = f['numero'];
                modelMensaje.numeroRecibe = messageDestinatario;

                lstMensajes.add(modelMensaje);
                // final logedUser = messageRemitente == numeroLoged ? true : false;
              }
            });
            lstMensajes.sort((a, b) => a.fecha.compareTo(b.fecha));
            print(lstMensajes);

            for (var mensaje in lstMensajes) {
              final messageWidget = MessageBubble(
                  sender: mensaje.numeroEnvia.toString(),
                  text: mensaje.mensaje,
                  logedUser: mensaje.numeroEnvia == numeroLoged ? true : false);
              messageWidgets.add(messageWidget);
            }
          }
        }

        return Expanded(
          child: ListView(
            reverse: false,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}
