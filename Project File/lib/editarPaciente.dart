import 'listaPaciente.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class ModificarPaciente extends StatefulWidget {
  final idperfil;
  final List<dynamic> perfil;
  ModificarPaciente({Key key, this.perfil, this.idperfil});

  @override
  _ModificarPacienteState createState() => _ModificarPacienteState();
}

class _ModificarPacienteState extends State<ModificarPaciente> {
  TextEditingController controlCodigo = TextEditingController();
  TextEditingController controlNombre = TextEditingController();
  TextEditingController controlApellido = TextEditingController();
  TextEditingController controlFoto = TextEditingController();
  TextEditingController controlFecha = TextEditingController();
  TextEditingController controlEdad = TextEditingController();
  TextEditingController controlDireccion = TextEditingController();
  TextEditingController controlCiudad = TextEditingController();
  TextEditingController controlTelefono = TextEditingController();
  bool activo = false;
  String activotxt;

  File imagen;
  final _picker = ImagePicker();

  _openGallary(BuildContext context) async {
    var picture = await _picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      imagen = File(picture.path);
      controlFoto.text = picture.path;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await _picker.getImage(source: ImageSource.camera);
    this.setState(() {
      imagen = File(picture.path);
      controlFoto.text = picture.path;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Elija una opción"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Galería"),
                    onTap: () {
                      _openGallary(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text("Cámara"),
                    onTap: () {
                      _openCamera(context);
                      controlFoto.text = imagen.toString();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ModificarPaciente(
                                      perfil: widget.perfil,
                                      idperfil: widget.idperfil)));
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    controlNombre =
        TextEditingController(text: widget.perfil[widget.idperfil]["nombre"]);
    controlApellido =
        TextEditingController(text: widget.perfil[widget.idperfil]["apellido"]);
    controlFoto =
        TextEditingController(text: widget.perfil[widget.idperfil]["foto"]);
    controlCodigo =
        TextEditingController(text: widget.perfil[widget.idperfil]["codigo"]);
    controlFecha =
        TextEditingController(text: widget.perfil[widget.idperfil]["fechaN"]);
    controlEdad =
        TextEditingController(text: widget.perfil[widget.idperfil]["edad"]);
    controlDireccion = TextEditingController(
        text: widget.perfil[widget.idperfil]["direccion"]);
    controlCiudad =
        TextEditingController(text: widget.perfil[widget.idperfil]["ciudad"]);
    controlTelefono =
        TextEditingController(text: widget.perfil[widget.idperfil]["telefono"]);

    activotxt = widget.perfil[widget.idperfil]["activo"];

    widget.perfil[widget.idperfil]["activo"] == 'SI'
        ? activo = true
        : activo = false;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar"),
        actions: [
          IconButton(
              tooltip: 'Cámara',
              icon: Icon(Icons.camera_enhance),
              onPressed: () {
                _showChoiceDialog(context);
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              TextField(
                controller: controlNombre,
                decoration: InputDecoration(labelText: "Nombre"),
              ),
              TextField(
                controller: controlApellido,
                decoration: InputDecoration(labelText: "Apellido"),
              ),
              TextField(
                controller: controlCodigo,
                decoration: InputDecoration(labelText: "Codigo"),
              ),
              TextField(
                controller: controlFoto,
                decoration: InputDecoration(labelText: "Foto"),
              ),
              TextField(
                controller: controlFecha,
                decoration: InputDecoration(labelText: "Fecha de Nacimiento"),
              ),
              TextField(
                controller: controlEdad,
                decoration: InputDecoration(labelText: "Edad"),
              ),
              TextField(
                controller: controlDireccion,
                decoration: InputDecoration(labelText: "Direccion"),
              ),
              TextField(
                controller: controlCiudad,
                decoration: InputDecoration(labelText: "Ciudad"),
              ),
              TextField(
                controller: controlTelefono,
                decoration: InputDecoration(labelText: "Telefono"),
              ),
              SwitchListTile(
                title: Text('Activo ?'),
                value: activo,
                onChanged: (bool value) {
                  setState(() {
                    activo = value;
                  });
                },
              ),
              ElevatedButton(
                child: Text("Modificar Personal"),
                onPressed: () {
                  activo == true ? activotxt = "SI" : activotxt = "NO";
                  update("paciente", widget.idperfil, {
                    "activo": activotxt,
                    "apellido": controlApellido.text,
                    "codigo": controlCodigo.text,
                    "fechaN": controlFecha.text,
                    "edad": controlEdad.text,
                    "direccion": controlDireccion.text,
                    "ciudad": controlCiudad.text,
                    "telefono": controlTelefono.text,
                    "foto": controlFoto.text,
                    "id": widget.perfil[widget.idperfil]["id"],
                    "nombre": controlNombre.text,
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
