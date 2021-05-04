import 'package:flutter/material.dart';
//import 'package:chat_list/chat_list.dart';
import 'package:laboratorio/models/UsuarioLiga.dart';
import 'package:firebase_database/firebase_database.dart';
import 'const.dart';
import 'main.dart';

List<UsuarioLiga> lstUsuariosLiga = [];
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
                    icon: new Icon(
                      Icons.home,
                      size: 35,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    },
                  ),
                  Text(
                    'Mensajes',
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        MessagesStream(_numero),
                        // MessageBubble(
                        //     sender: "Marcos", text: "Hola", logedUser: false),
                        // MessageBubble(
                        //     sender: "Pedro", text: "Hola", logedUser: true),
                        // MessageBubble(
                        //     sender: "Marcos",
                        //     text: "Como estas",
                        //     logedUser: false),
                        Container(
                          decoration: kMessageContainerDecoration,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  // controller: messageTextController,
                                  onChanged: (value) {
                                    mensaje = value;
                                  },
                                  decoration: kMessageTextFieldDecoration,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  DateTime now = new DateTime.now();
                                  DateTime date = new DateTime(
                                      now.year, now.month, now.day);
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
                                  ;
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
                ],
              )
            ],
          ),
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
  int numeroLoged;
  MessagesStream(this.numeroLoged);
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
        if (snapshot.hasData) {
          final messages = snapshot.data;
          print(messages.snapshot.value);
          Map<dynamic, dynamic> getMapPrductos = messages.snapshot.value;
          getMapPrductos.forEach((key, value) {
            Map<dynamic, dynamic> f = value;
            final messsageText = f['mensaje'];
            final messageRemitente = f['numero'].toString();
            final messageDestinatario = f['para'];

            print(messageDestinatario);
            // final logedUser = messageRemitente == numeroLoged ? true : false;
            final messageWidget = MessageBubble(
                sender: messageRemitente,
                text: messsageText,
                logedUser:
                    messageRemitente == numeroLoged.toString() ? true : false);
            messageWidgets.add(messageWidget);
          });
        }

        return Container(
          height: 200,
          child: Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageWidgets,
            ),
          ),
        );
      },
    );
  }
}
