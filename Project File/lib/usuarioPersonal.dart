import 'package:crudcompletoapi/crearCita.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'crearCita.dart';
import 'main.dart';
import 'perfilCitaUsuario.dart';
import 'dart:convert';
import 'listapaciente.dart';

class ListaUsuario extends StatefulWidget {
  ListaUsuario({Key key, this.title, this.personal}) : super(key: key);
  final String title;
  final Map personal;
  @override
  _ListaUsuarioState createState() => _ListaUsuarioState();
}

class _ListaUsuarioState extends State<ListaUsuario> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.personal["tipo"] +
            " " +
            widget.personal["apellido"] +
            ' Citas'),
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
          },
        ),
      ),

      body: getInfo(context, widget.personal),

      floatingActionButton: Row(children: [
        SizedBox(
          width: 30,
        ),
        FloatingActionButton(
          onPressed: () {
            setState(() {
              getInfo(context, widget.personal);
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

Widget getInfo(BuildContext context, Map personal) {
  return FutureBuilder<dynamic>(
    future: read(
        "combo"), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
        print("hhhhhhhhhhh");
        print(snapshot.data[1]);
        return VistaCitas(
          citas: snapshot.data[0],
          personal: personal,
          pacientes: snapshot.data[1],
        );
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}

class VistaCitas extends StatelessWidget {
  final List<dynamic> citas;
  final Map personal;
  final List<dynamic> pacientes;
  const VistaCitas({Key key, this.citas, this.personal, this.pacientes})
      : super(key: key);
  // _buscarPacientes(_elegircitas(citas, personal),pacientes)
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _elegircitas(citas, personal) == null
            ? 0
            : _elegircitas(citas, personal).length,
        itemBuilder: (context, posicion) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => PerfilCita(
                          perfil: _elegircitas(citas, personal),
                          idperfil: posicion,
                          paciente: _buscarPacientes(
                              _elegircitas(citas, personal)[posicion],
                              pacientes))));
            },
            leading: Container(
              padding: EdgeInsets.all(5.0),
              width: 50,
              height: 50,
              child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.gofreedownload.net/2/green-clock-icon-5677.jpg")),
            ),
            title: Text(_elegircitas(citas, personal)[posicion]["fecha"]),
            subtitle: Text(_elegircitas(citas, personal)[posicion]["hora"]),
          );
        });
  }
}

// _buscarPacientes(_elegircitas(citas, personal),pacientes)
_buscarPacientes(Map citas, List pacientes) {
  Map paciente = {};
  for (Map j in pacientes) {
    if (citas["codigoPaciente"] == j["codigo"] &&
        citas["nombrePaciente"] == j["nombre"] &&
        citas["apellidoPaciente"] == j["apellido"]) {
      paciente = j;
    }
  }
  print("AAAAAAAAAAA");
  print(citas);
  return paciente;
}

_elegircitas(List citas, Map personal) {
  List lista = [];
  for (Map i in citas) {
    if (i["codigoPersonal"] == personal["codigo"] &&
        i["nombrePersonal"] == personal["nombre"] &&
        i["apellidoPersonal"] == personal["apellido"]) {
      lista.add(i);
    }
  }
  return lista;
}
