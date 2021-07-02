import 'package:crudcompletoapi/crearCita.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'crearCita.dart';
import 'main.dart';
import 'perfilCita.dart';
import 'dart:convert';
import 'listapaciente.dart';

class ListaCita extends StatefulWidget {
  ListaCita({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ListaCitaState createState() => _ListaCitaState();
}

class _ListaCitaState extends State<ListaCita> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Citas'),
        actions: [
          IconButton(
              tooltip: 'Crear Citas',
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            createDate(context)));
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
        "combo"), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
        return VistaCitas(
          citas: snapshot.data[0],
          personal: snapshot.data[2],
          paciente: snapshot.data[1],
        );
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}

class VistaCitas extends StatelessWidget {
  final List<dynamic> citas;
  final List<dynamic> paciente;
  final List<dynamic> personal;
  const VistaCitas({Key key, this.citas, this.paciente, this.personal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: citas == null ? 0 : citas.length,
        itemBuilder: (context, posicion) {
          return ListTile(
            onTap: () {
              print(citas);
              print(posicion);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          PerfilCita(perfil: citas, idperfil: posicion)));
            },
            leading: Container(
              padding: EdgeInsets.all(5.0),
              width: 50,
              height: 50,
              child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.gofreedownload.net/2/green-clock-icon-5677.jpg")),
            ),
            title: Text(citas[posicion]["fecha"]),
            subtitle: Text(citas[posicion]["hora"]),
          );
        });
  }
}

Widget createDate(BuildContext context) {
  return FutureBuilder<dynamic>(
    future: read(
        "combo"), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
        return AgregarCita(
          personal: snapshot.data[2],
          paciente: snapshot.data[1],
        );
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}
