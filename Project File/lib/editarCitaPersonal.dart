import 'listaPaciente.dart';
import 'main.dart';
import 'package:flutter/material.dart';

class ModificarCita extends StatefulWidget {
  final idperfil;
  final List<dynamic> perfil;
  ModificarCita({Key key, this.perfil, this.idperfil});

  @override
  _ModificarCitaState createState() => _ModificarCitaState();
}

class User {
  const User(this.name);
  final String name;
}

class _ModificarCitaState extends State<ModificarCita> {
  TextEditingController controlCodigoPaciente = TextEditingController();
  TextEditingController controlNombrePaciente = TextEditingController();
  TextEditingController controlApellidoPaciente = TextEditingController();
  TextEditingController controlCodigoPersonal = TextEditingController();
  TextEditingController controlNombrePersonal = TextEditingController();
  TextEditingController controlApellidoPersonal = TextEditingController();
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
  void initState() {
    controlNombrePaciente = TextEditingController(
        text: widget.perfil[widget.idperfil]["nombrePaciente"]);
    controlApellidoPaciente = TextEditingController(
        text: widget.perfil[widget.idperfil]["apellidoPaciente"]);
    controlCodigoPaciente = TextEditingController(
        text: widget.perfil[widget.idperfil]["codigoPaciente"]);
    controlNombrePersonal = TextEditingController(
        text: widget.perfil[widget.idperfil]["nombrePersonal"]);
    controlApellidoPersonal = TextEditingController(
        text: widget.perfil[widget.idperfil]["apellidoPersonal"]);
    controlCodigoPersonal = TextEditingController(
        text: widget.perfil[widget.idperfil]["codigoPersonal"]);
    controlFecha =
        TextEditingController(text: widget.perfil[widget.idperfil]["fecha"]);
    controlHora =
        TextEditingController(text: widget.perfil[widget.idperfil]["hora"]);
    controlDescripcion = TextEditingController(
        text: widget.perfil[widget.idperfil]["descripcion"]);
    controlEstado = widget.perfil[widget.idperfil]["estado"];

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
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
                child: Text("Modificar Citas"),
                onPressed: () {
                  update("citas", widget.perfil[widget.idperfil]["id"], {
                    "apellidoPaciente": controlApellidoPaciente.text,
                    "apellidoPersonal": controlApellidoPersonal.text,
                    "codigoPaciente": controlCodigoPaciente.text,
                    "codigoPersonal": controlCodigoPersonal.text,
                    "id": widget.perfil[widget.idperfil]["id"],
                    "fecha": controlFecha.text,
                    "hora": controlHora.text,
                    "descripcion": controlDescripcion.text,
                    "estado": controlEstado,
                    "nombrePaciente": controlNombrePaciente.text,
                    "nombrePersonal": controlNombrePersonal.text
                  });
                  setState(() {
                    getInfo(context);
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
