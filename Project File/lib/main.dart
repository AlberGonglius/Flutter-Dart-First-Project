import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';
import 'dart:convert';
import 'login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

final DBRef = FirebaseDatabase.instance.reference();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clínica del Buen Doctor',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
      },
    );
  }
}

read(String tipo) async {
  if (tipo != "combo") {
    List<dynamic> a = [];
    await DBRef.child("Datos").once().then((DataSnapshot d) async {
      Map<dynamic, dynamic> values = d.value;
      values.forEach((key, values) {
        if (key == tipo) {
          for (Map i in values) {
            a.add(Map.from(i));
          }
        }
      });
    });
    return a;
  } else {
    List<dynamic> a = [];
    List<dynamic> b = [];
    List<dynamic> c = [];
    await DBRef.child("Datos").once().then((DataSnapshot d) async {
      Map<dynamic, dynamic> values = d.value;
      values.forEach((key, values) {
        if (key == "citas") {
          for (Map i in values) {
            a.add(Map.from(i));
          }
        }
      });
    });
    await DBRef.child("Datos").once().then((DataSnapshot d) async {
      Map<dynamic, dynamic> values = d.value;
      values.forEach((key, values) {
        if (key == "paciente") {
          for (Map i in values) {
            b.add(Map.from(i));
          }
        }
      });
    });
    await DBRef.child("Datos").once().then((DataSnapshot d) async {
      Map<dynamic, dynamic> values = d.value;
      values.forEach((key, values) {
        if (key == "personal") {
          for (Map i in values) {
            c.add(Map.from(i));
          }
        }
      });
    });
    return [a, b, c];
  }
}

void add(String tipo, Map elemento) async {
  if (elemento != {}) {
    List list = await read(tipo);
    print("1");
    list.add(elemento);
    if (list.length > 0) {
      list[list.length - 1]["id"] = list.length - 1;
    } else {
      list[0]["id"] = 0;
    }

    print("2");
    List tipos = ['personal', 'pacientes', 'citas'];
    List tipos2 = [];
    for (String t in tipos) {
      if (tipo != t) {
        tipos2.add(t);
      }
    }
    List list2 = await read(tipos2[0]);
    List list3 = await read(tipos2[1]);
    print("3");
    DBRef.child("Datos")
        .update({tipo: list, tipos2[0]: list2, tipos2[1]: list3});
  }
}

void update(String tipo, id, Map elemento) async {
  if (elemento != {} && id != null) {
    List list = await read(tipo);
    list[id] = elemento;

    List tipos = ['personal', 'pacientes', 'citas'];
    List tipos2 = [];
    for (String t in tipos) {
      if (tipo != t) {
        tipos2.add(t);
      }
    }
    List list2 = await read(tipos2[0]);
    List list3 = await read(tipos2[1]);

    DBRef.child("Datos")
        .update({tipo: list, tipos2[0]: list2, tipos2[1]: list3});
  }
}

void delete(String tipo, int id) async {
  if (id != null) {
    List list = await read(tipo);
    list.removeAt(id);
    int indice = 0;
    for (Map j in list) {
      j["id"] = indice;
      indice = indice + 1;
    }
    List tipos = ['personal', 'pacientes', 'citas'];
    List tipos2 = [];
    for (String t in tipos) {
      if (tipo != t) {
        tipos2.add(t);
      }
    }
    List list2 = await read(tipos2[0]);
    List list3 = await read(tipos2[1]);
    print("3");
    DBRef.child("Datos")
        .update({tipo: list, tipos2[0]: list2, tipos2[1]: list3});
  }
}
