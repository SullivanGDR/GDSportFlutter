import 'package:flutter/material.dart';
import 'package:gdsport_flutter/catalogue.dart';
import 'package:gdsport_flutter/connexion.dart';
import 'package:gdsport_flutter/homepage.dart';
import 'package:gdsport_flutter/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GDSport',
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/connexion': (BuildContext context) => Connexion(),
        '/catalogue': (BuildContext context) => Catalogue(),
        '/register': (BuildContext context) => Register(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
