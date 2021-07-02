import 'package:flutter/material.dart';
import 'listapersonal.dart';
import 'main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class AgregarPersonal extends StatefulWidget {
  @override
  _AgregarPersonalState createState() => _AgregarPersonalState();
}

class _AgregarPersonalState extends State<AgregarPersonal> {
  TextEditingController controlCodigo = TextEditingController();
  TextEditingController controlNombre = TextEditingController();
  TextEditingController controlApellido = TextEditingController();
  TextEditingController controlFoto = TextEditingController();
  TextEditingController controlTipo = TextEditingController();
  TextEditingController controlLogin = TextEditingController();
  TextEditingController controlPassword = TextEditingController();
  bool activo = false;
  bool en_servicio = false;

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
        title: Text("Adicionar Personal"),
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
                controller: controlTipo,
                decoration: InputDecoration(labelText: "Tipo"),
              ),
              TextField(
                controller: controlLogin,
                decoration: InputDecoration(labelText: "Login"),
              ),
              TextField(
                controller: controlPassword,
                decoration: InputDecoration(labelText: "Contraseña"),
              ),
              SwitchListTile(
                title: Text('En Servicio?'),
                value: en_servicio,
                onChanged: (bool value) {
                  setState(() {
                    en_servicio = value;
                  });
                },
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
                child: Text("Adicionar Personal"),
                onPressed: () {
                  String en_serviciotxt = "NO";
                  String activotxt = "NO";
                  en_servicio == true
                      ? en_serviciotxt = "SI"
                      : en_serviciotxt = "NO";
                  activo == true ? activotxt = "SI" : activotxt = "NO";
                  add("personal", {
                    "activo": activotxt,
                    "apellido": controlApellido.text,
                    "codigo": controlCodigo.text,
                    "en_servicio": en_serviciotxt,
                    "foto": controlFoto.text,
                    "login": controlLogin.text,
                    "contraseña": controlPassword.text,
                    "id": 0,
                    "nombre": controlNombre.text,
                    "tipo": controlTipo.text
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
