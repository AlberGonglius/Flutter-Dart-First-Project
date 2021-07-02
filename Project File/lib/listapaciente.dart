import 'adicionarPaciente.dart';
import 'perfilPaciente.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'adicionar.dart';
import 'main.dart';
import 'perfilPaciente.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class ListaPaciente extends StatefulWidget {
  ListaPaciente({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ListaPacienteState createState() => _ListaPacienteState();
}

class _ListaPacienteState extends State<ListaPaciente> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pacientes'),
        actions: [
          IconButton(
              tooltip: 'Adicionar Paciente',
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AgregarPaciente()));
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
      ]),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget getInfo(BuildContext context) {
  return FutureBuilder<dynamic>(
    future: read(
        "paciente"), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
        return VistaPaciente(paciente: snapshot.data);
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}

class VistaPaciente extends StatelessWidget {
  final List<dynamic> paciente;
  const VistaPaciente({Key key, this.paciente}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("1");
    print(paciente);
    return ListView.builder(
        itemCount: paciente == null ? 0 : paciente.length,
        itemBuilder: (context, posicion) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => PerfilPaciente(
                          perfil: paciente, idperfil: posicion)));
            },
            leading: Container(
              padding: EdgeInsets.all(5.0),
              width: 50,
              height: 50,
              child: CircleAvatar(
                  backgroundImage: _tipo_imagen(paciente[posicion]["foto"])),
            ),
            title: Text(paciente[posicion]["nombre"] +
                " " +
                paciente[posicion]["apellido"]),
            subtitle: Text(paciente[posicion]["edad"]),
            trailing: Container(
              width: 80,
              height: 40,
              color: Colors.yellowAccent,
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(paciente[posicion]["codigo"]),
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
