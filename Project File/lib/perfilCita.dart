import 'main.dart';
import 'package:flutter/material.dart';
import 'citas.dart';
import 'editarCita.dart';

var contextoppal;

class PerfilCita extends StatelessWidget {
  final idperfil;
  final List<dynamic> perfil;

  PerfilCita({Key key, this.perfil, this.idperfil});
  @override
  Widget build(BuildContext context) {
    contextoppal = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cita',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cita'),
          actions: [
            IconButton(
                tooltip: 'Editar',
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ModificarCita(
                              perfil: perfil, idperfil: idperfil)));
                }),
            IconButton(
                tooltip: 'Eliminar',
                icon: Icon(Icons.delete),
                onPressed: () {
                  confirmaeliminar(context, idperfil);
                })
          ],
        ),
        body: ListView(children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
            height: 460,
            width: double.maxFinite,
            child: Card(
              elevation: 5,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    left: (MediaQuery.of(context).size.width / 2) - 65,
                    child: Container(
                      height: 100,
                      width: 100,
                      //color: Colors.blue,
                      child: Card(
                        elevation: 2,
                        child: Image.network(
                            "https://images.gofreedownload.net/2/green-clock-icon-5677.jpg"),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Column(
                            children: [
                              Text(
                                "",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(""),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Datos de la cita'),
                              SizedBox(
                                height: 15,
                              ),
                              Text("Personal Asignado: " +
                                  perfil[idperfil]["nombrePersonal"] +
                                  " " +
                                  perfil[idperfil]["apellidoPersonal"]),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Paciente: " +
                                  perfil[idperfil]["nombrePaciente"] +
                                  " " +
                                  perfil[idperfil]["apellidoPaciente"]),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Descripción: " +
                                  perfil[idperfil]["descripcion"]),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Estado:'),
                              SizedBox(height: 10),
                              Container(
                                width: 200,
                                height: 50,
                                color: colorEstado(perfil, idperfil),
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                child: Text(
                                  perfil[idperfil]["estado"],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                getInfo(context);
              },
              child: Text('Regresar'))
        ]),
      ),
    );
  }
}

void confirmaeliminar(context, ideliminar) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text('Realmente Desea Eliminar?'),
        actions: <Widget>[
          ElevatedButton(
            child: Icon(Icons.cancel),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            ),
            child: Icon(Icons.check_circle),
            onPressed: () {
              delete("citas", ideliminar);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

colorEstado(List perfil, int idperfil) {
  var color;
  if (perfil[idperfil]["estado"] == "Atendido" ||
      perfil[idperfil]["estado"] == "Asignado") {
    color = Colors.greenAccent;
  } else if (perfil[idperfil]["estado"] == "En Servicio") {
    color = Colors.yellowAccent;
  } else {
    color = Colors.redAccent;
  }
  return color;
}
