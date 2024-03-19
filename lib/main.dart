import 'package:flutter/material.dart';
import 'package:gdsport_flutter/catalogue.dart';
import 'package:gdsport_flutter/commande.dart';
import 'package:gdsport_flutter/connexion.dart';
import 'package:gdsport_flutter/favoris.dart';
import 'package:gdsport_flutter/homepage.dart';
import 'package:gdsport_flutter/profil.dart';
import 'package:gdsport_flutter/register.dart';
import 'package:gdsport_flutter/modifProfil.dart';

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
        '/accueil': (BuildContext context) => const MyHomePage(),
        '/connexion': (BuildContext context) => const Connexion(),
        '/catalogue': (BuildContext context) => const Catalogue(),
        '/register': (BuildContext context) => const Register(),
        '/favoris': (BuildContext context) => const FavorisPage(),
        '/profil': (BuildContext context) => const Profil(),
        '/modifProfil': (BuildContext context) => const ModifProfil(),
        '/commande': (BuildContext context) => const Commande(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
