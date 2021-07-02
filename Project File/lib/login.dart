import 'package:flutter/material.dart';
import 'listapersonal.dart';
import 'main.dart';
import 'usuarioPersonal.dart';

class LoginPage extends StatefulWidget {
  static String id = "login_page";
  final List<dynamic> p;
  const LoginPage({Key key, this.p}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getInfo(context));
  }
}

Widget getInfo(BuildContext context) {
  return FutureBuilder<dynamic>(
    future: read(
        "personal"), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
        return VistaLogin(
          p: snapshot.data,
        );
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}

class VistaLogin extends StatelessWidget {
  final passwordControler = TextEditingController();
  final userControler = TextEditingController();
  final List<dynamic> p;
  VistaLogin({Key key, this.p}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Center(child: Text('Clínica del Buen Doctor'))),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Image.asset(
                  "images/login.jpg",
                  height: 300,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              _userTextField(),
              SizedBox(
                height: 15,
              ),
              _passwordTextField(),
              SizedBox(
                height: 20,
              ),
              _bottonLogin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          controller: userControler,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            icon: Icon(Icons.verified_user),
            hintText: "Inserte su usuario",
            labelText: "Usuario",
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  _passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          controller: passwordControler,
          keyboardType: TextInputType.name,
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            hintText: "Inserte su contraseña",
            labelText: "Contraseña",
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  Widget _bottonLogin() {
    String password = 'hola';
    String user = 'hola';
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text("Iniciar Sesión "),
          ),
          onPressed: () {
            if (userControler.text.isEmpty || passwordControler.text.isEmpty) {
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text("Porfavor ingrese usuario y/o contraseña."),
                  );
                },
              );
            } else if (userControler.text == user &&
                passwordControler.text == password) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          ListaPersonal(title: 'Clínica del Buen Doctor')));
            } else if (buscar_clave(
                        p, userControler.text, passwordControler.text)
                    .length !=
                0) {
              print("XDD");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ListaUsuario(
                          title: 'Clínica del Buen Doctor',
                          personal: buscar_clave(
                              p, userControler.text, passwordControler.text))));
            } else {
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text("usuario y/o contraseña incorrect@(s)."),
                  );
                },
              );
            }
          });
    });
  }
}

buscar_clave(List p, String login, String password) {
  List clave = [];
  print(login);
  print(password);
  for (Map i in p) {
    if (i["login"] == login && i["contraseña"] == password) {
      clave.add(i);
    }
  }
  print(clave);
  if (clave.length != 0) {
    return clave[0];
  } else {
    return clave;
  }
}
