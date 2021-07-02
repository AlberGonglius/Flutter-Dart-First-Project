import 'package:flutter/material.dart';
import 'citas.dart';
import 'main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class AgregarCita extends StatefulWidget {
  final List<dynamic> paciente;
  final List<dynamic> personal;

  AgregarCita({Key key, this.paciente, this.personal}) : super(key: key);
  @override
  _AgregarCitaState createState() => _AgregarCitaState();
}

class User {
  const User(this.name);
  final String name;
}

class _AgregarCitaState extends State<AgregarCita> {
  List<dynamic> paciente;
  List<dynamic> personal;
  String controlNombrePaciente;
  String controlCodigoPaciente;
  String controlApellidoPaciente;
  String controlCodigoPersonal;
  String controlNombrePersonal;
  String controlApellidoPersonal;
  @override
  void initState() {
    paciente = widget.paciente;
    personal = widget.personal;
    controlNombrePaciente = paciente[0]["nombre"];
    controlApellidoPaciente = paciente[0]["apellido"];
    controlCodigoPaciente = paciente[0]["codigo"];
    controlNombrePersonal = personal[0]["nombre"];
    controlApellidoPersonal = personal[0]["apellido"];
    controlCodigoPersonal = personal[0]["codigo"];
  }

  TextEditingController controlFecha = TextEditingController();
  TextEditingController controlHora = TextEditingController();
  String controlEstado = "";
  TextEditingController controlDescripcion = TextEditingController();
  User selectedUser;

  List<User> users = <User>[
    User('Atendido'),
    User('En Servicio'),
    User('No Atendido'),
    User('Asignado'),
    User('Anulado')
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Crear cita"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              new DropdownButtonFormField(
                value: controlNombrePaciente,
                hint: new Text("Nombre del paciente"),
                items: crearListaItem(widget.paciente, "nombre")
                    .map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(
                      value,
                      style: new TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    controlNombrePaciente = value;
                    controlApellidoPaciente = apellidoPorNombre(
                        widget.paciente, "apellido", controlNombrePaciente)[0];
                    controlCodigoPaciente = codigoPorNA(
                        widget.paciente,
                        "codigo",
                        controlNombrePaciente,
                        controlApellidoPaciente)[0];
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Nombre del Paciente',
                ),
              ),
              new DropdownButtonFormField(
                value: controlApellidoPaciente,
                hint: new Text("Apellido del Paciente"),
                items: apellidoPorNombre(
                        widget.paciente, "apellido", controlNombrePaciente)
                    .map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(
                      value,
                      style: new TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    controlApellidoPaciente = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Apellido del Paciente',
                ),
              ),
              new DropdownButtonFormField(
                value: controlCodigoPaciente,
                hint: new Text("Código del Paciente"),
                items: codigoPorNA(widget.paciente, "codigo",
                        controlNombrePaciente, controlApellidoPaciente)
                    .map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(
                      value,
                      style: new TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    controlCodigoPaciente = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Código del Paciente',
                ),
              ),
              new DropdownButtonFormField(
                value: controlNombrePersonal,
                hint: new Text("Nombre del personal"),
                items: crearListaItem(widget.personal, "nombre")
                    .map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(
                      value,
                      style: new TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    controlNombrePersonal = value;
                    controlApellidoPersonal = apellidoPorNombre(
                        widget.personal, "apellido", controlNombrePersonal)[0];
                    controlCodigoPersonal = codigoPorNA(
                        widget.personal,
                        "codigo",
                        controlNombrePersonal,
                        controlApellidoPersonal)[0];
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Nombre del Personal',
                ),
              ),
              new DropdownButtonFormField(
                value: controlApellidoPersonal,
                hint: new Text("Apellido del Personal"),
                items: apellidoPorNombre(
                        widget.personal, "apellido", controlNombrePersonal)
                    .map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(
                      value,
                      style: new TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    controlApellidoPersonal = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Apellido del Personal',
                ),
              ),
              new DropdownButtonFormField(
                value: controlCodigoPersonal,
                hint: new Text("Código del Personal"),
                items: codigoPorNA(widget.personal, "codigo",
                        controlNombrePersonal, controlApellidoPersonal)
                    .map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(
                      value,
                      style: new TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    controlCodigoPersonal = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Código del Personal',
                ),
              ),
              TextField(
                controller: controlFecha,
                decoration: InputDecoration(labelText: "Fecha"),
              ),
              TextField(
                controller: controlHora,
                decoration: InputDecoration(labelText: "Hora"),
              ),
              TextField(
                controller: controlDescripcion,
                decoration: InputDecoration(labelText: "Descripcion"),
              ),
              new DropdownButton<User>(
                hint: new Text("Estado"),
                value: selectedUser,
                onChanged: (User newValue) {
                  setState(() {
                    selectedUser = newValue;
                    controlEstado = selectedUser.name;
                    print(controlEstado);
                  });
                },
                items: users.map((User user) {
                  return new DropdownMenuItem<User>(
                    value: user,
                    child: new Text(
                      user.name,
                      style: new TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
              ElevatedButton(
                child: Text("Crear Cita"),
                onPressed: () {
                  add("citas", {
                    "apellidoPaciente": controlApellidoPaciente,
                    "apellidoPersonal": controlApellidoPersonal,
                    "codigoPaciente": controlCodigoPaciente,
                    "codigoPersonal": controlCodigoPersonal,
                    "id": 0,
                    "fecha": controlFecha.text,
                    "hora": controlHora.text,
                    "descripcion": controlDescripcion.text,
                    "estado": controlEstado,
                    "nombrePaciente": controlNombrePaciente,
                    "nombrePersonal": controlNombrePersonal
                  });
                  getInfo(context);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> crearListaItem(tipo, variable) {
  List<String> lista = [];
  for (var i = 0; i < tipo.length; i++) {
    lista.add(tipo[i][variable]);
  }
  print(lista);
  return lista;
}

List<String> apellidoPorNombre(tipo, variable, nombre) {
  List<String> lista = [];
  for (var i = 0; i < tipo.length; i++) {
    if (tipo[i]["nombre"] == nombre) {
      lista.add(tipo[i][variable]);
    }
  }
  print(lista);
  return lista;
}

List<String> codigoPorNA(tipo, variable, nombre, apellido) {
  List<String> lista = [];
  for (var i = 0; i < tipo.length; i++) {
    if (tipo[i]["nombre"] == nombre && tipo[i]["apellido"] == apellido) {
      lista.add(tipo[i][variable]);
    }
  }
  print("holax");
  print(lista);
  return lista;
}
