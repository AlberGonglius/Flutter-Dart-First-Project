import 'listaPersonal.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class ModificarPersonal extends StatefulWidget {
  final idperfil;
  final List<dynamic> perfil;
  ModificarPersonal({Key key, this.perfil, this.idperfil});

  @override
  _ModificarPersonalState createState() => _ModificarPersonalState();
}

class _ModificarPersonalState extends State<ModificarPersonal> {
  TextEditingController controlCodigo = TextEditingController();
  TextEditingController controlNombre = TextEditingController();
  TextEditingController controlApellido = TextEditingController();
  TextEditingController controlFoto = TextEditingController();
  TextEditingController controlTipo = TextEditingController();
  TextEditingController controlLogin = TextEditingController();
  TextEditingController controlPassword = TextEditingController();
  bool activo = false;
  bool en_servicio = false;
  String activotxt;
  String en_serviciotxt;

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
                                  ModificarPersonal(
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
    controlTipo =
        TextEditingController(text: widget.perfil[widget.idperfil]["tipo"]);
    controlCodigo =
        TextEditingController(text: widget.perfil[widget.idperfil]["codigo"]);
    controlLogin =
        TextEditingController(text: widget.perfil[widget.idperfil]["login"]);
    controlPassword = TextEditingController(
        text: widget.perfil[widget.idperfil]["contraseña"]);
    activotxt = widget.perfil[widget.idperfil]["activo"];
    en_serviciotxt = widget.perfil[widget.idperfil]["en_servicio"];

    widget.perfil[widget.idperfil]["en_servicio"] == 'SI'
        ? en_servicio = true
        : en_servicio = false;
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
                controller: controlFoto,
                decoration: InputDecoration(labelText: "Foto"),
              ),
              TextField(
                controller: controlCodigo,
                decoration: InputDecoration(labelText: "Codigo"),
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
                title: Text('En serivicio?'),
                value: en_servicio,
                onChanged: (bool value) {
                  setState(() {
                    en_servicio = value;
                  });
                },
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
                  en_servicio == true
                      ? en_serviciotxt = "SI"
                      : en_serviciotxt = "NO";
                  activo == true ? activotxt = "SI" : activotxt = "NO";
                  update("personal", widget.idperfil, {
                    "activo": activotxt,
                    "apellido": controlApellido.text,
                    "codigo": controlCodigo.text,
                    "en_servicio": en_serviciotxt,
                    "foto": controlFoto.text,
                    "login": controlLogin.text,
                    "contraseña": controlPassword.text,
                    "id": widget.perfil[widget.idperfil]["id"],
                    "nombre": controlNombre.text,
                    "tipo": controlTipo.text
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
