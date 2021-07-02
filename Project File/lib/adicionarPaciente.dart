import 'package:flutter/material.dart';
import 'listapaciente.dart';
import 'main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class AgregarPaciente extends StatefulWidget {
  @override
  _AgregarPacienteState createState() => _AgregarPacienteState();
}

class _AgregarPacienteState extends State<AgregarPaciente> {
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
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Paciente"),
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
                decoration: InputDecoration(labelText: "Fecha de Nacimento"),
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
                title: Text('Activo?'),
                value: activo,
                onChanged: (bool value) {
                  setState(() {
                    activo = value;
                  });
                },
              ),
              ElevatedButton(
                child: Text("Adicionar Paciente"),
                onPressed: () {
                  String activotxt = "NO";
                  activo == true ? activotxt = "SI" : activotxt = "NO";
                  add("paciente", {
                    "activo": activotxt,
                    "apellido": controlApellido.text,
                    "codigo": controlCodigo.text,
                    "fechaN": controlFecha.text,
                    "edad": controlEdad.text,
                    "direccion": controlDireccion.text,
                    "ciudad": controlCiudad.text,
                    "telefono": controlTelefono.text,
                    "foto": controlFoto.text,
                    "id": 0,
                    "nombre": controlNombre.text
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
