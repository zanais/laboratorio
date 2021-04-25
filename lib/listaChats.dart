import 'package:flutter/material.dart';
import 'package:laboratorio/chats.dart';

import 'main.dart';

class ListaChats extends StatefulWidget {
  @override
  _ListaChatsState createState() => _ListaChatsState();
}

class _ListaChatsState extends State<ListaChats> {
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
                              builder: (context) => MyHomePage()));
                    },
                  ),
                  Text('Mensajes'),
                ],
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Contactos("M", "Marcos Medina"),
                  Contactos("E", "Eduardo Medina"),
                  Contactos("S", "Carlos Tovar ")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Contactos extends StatelessWidget {
  Contactos(this.inicial, this.nombre);
  String inicial;
  String nombre;
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
                  "$inicial",
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Chats()));
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
