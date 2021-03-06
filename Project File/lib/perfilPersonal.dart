import 'main.dart';
import 'package:flutter/material.dart';
import 'listaPersonal.dart';
import 'editarPersonal.dart';

var contextoppal;

class PerfilPersonal extends StatelessWidget {
  final idperfil;
  final List<dynamic> perfil;
  PerfilPersonal({Key key, this.perfil, this.idperfil});

  @override
  Widget build(BuildContext context) {
    contextoppal = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perfil',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perfil Personal Atención'),
          actions: [
            IconButton(
                tooltip: 'Editar',
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ModificarPersonal(
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
                        child: Image.network(perfil[idperfil]["foto"]),
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
                                perfil[idperfil]["nombre"] +
                                    " " +
                                    perfil[idperfil]["apellido"],
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(perfil[idperfil]["tipo"]),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Disponibilidad'),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text('En Servicio'),
                                      CircleAvatar(
                                        child: Text(
                                            perfil[idperfil]["en_servicio"]),
                                        backgroundColor: perfil[idperfil]
                                                    ["en_servicio"] ==
                                                'NO'
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('ACTIVO'),
                                      CircleAvatar(
                                        child: Text(perfil[idperfil]["activo"]),
                                        backgroundColor:
                                            perfil[idperfil]["activo"] == 'NO'
                                                ? Colors.red
                                                : Colors.green,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Código:'),
                              SizedBox(height: 10),
                              Container(
                                width: 100,
                                height: 50,
                                color: Colors.yellowAccent,
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                child: Text(
                                  perfil[idperfil]["codigo"],
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
              delete("personal", ideliminar);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
