import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'adicionar.dart';
import 'main.dart';
import 'perfilPersonal.dart';
import 'dart:convert';
import 'listapaciente.dart';
import 'citas.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class ListaPersonal extends StatefulWidget {
  ListaPersonal({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ListaPersonalState createState() => _ListaPersonalState();
}

class _ListaPersonalState extends State<ListaPersonal> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal de Atención'),
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
          },
        ),
        actions: [
          IconButton(
              tooltip: 'Adicionar Personal',
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AgregarPersonal()));
              })
        ],
      ),

      body: getInfo(context),

      floatingActionButton: Row(children: [
        SizedBox(
          width: 30,
        ),
        FloatingActionButton(
          onPressed: () {
            setState(() {
              getInfo(context);
            });
          },
          tooltip: 'Actualizar',
          child: Icon(Icons.refresh),
        ),
        SizedBox(
          width: 10,
        ),
        FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        ListaPaciente(title: 'Clínica del Buen Doctor')));
          },
          tooltip: 'Ver Todos los Pacientes',
          child: Icon(Icons.person),
        ),
        SizedBox(
          width: 10,
        ),
        FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        ListaCita(title: 'Clínica del Buen Doctor')));
          },
          tooltip: 'Agendar Cita',
          child: Icon(Icons.calendar_today),
        ),
        SizedBox(
          width: 130,
        ),
        FloatingActionButton(
          onPressed: () async => await launch(
              "https://api.whatsapp.com/send?phone=${"+57" + "3002574395"}"),
          tooltip: 'Ayuda',
          child: Icon(Icons.help),
        ),
      ]),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget getInfo(BuildContext context) {
  return FutureBuilder<dynamic>(
    future: read(
        "personal"), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
        return VistaPersonal(personal: snapshot.data);
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}

class VistaPersonal extends StatelessWidget {
  final List<dynamic> personal;
  const VistaPersonal({Key key, this.personal}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("1");
    print(personal);
    return ListView.builder(
        itemCount: personal == null ? 0 : personal.length,
        itemBuilder: (context, posicion) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => PerfilPersonal(
                          perfil: personal, idperfil: posicion)));
            },
            leading: Container(
              padding: EdgeInsets.all(5.0),
              width: 50,
              height: 50,
              child: CircleAvatar(
                  backgroundImage: _tipo_imagen(personal[posicion]["foto"])),
            ),
            title: Text(personal[posicion]["nombre"] +
                " " +
                personal[posicion]["apellido"]),
            subtitle: Text(personal[posicion]["tipo"]),
            trailing: Container(
              width: 80,
              height: 40,
              color: Colors.yellowAccent,
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(personal[posicion]["codigo"]),
            ),
          );
        });
  }
}

_tipo_imagen(imagen) {
  if (imagen.contains("http")) {
    return NetworkImage(imagen);
  } else {
    return FileImage(File(imagen));
  }
}
