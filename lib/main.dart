import 'package:flutter/material.dart';
import 'package:gdsport_flutter/catalAll.dart';
import 'package:gdsport_flutter/catalogue.dart';
import 'package:gdsport_flutter/commande.dart';
import 'package:gdsport_flutter/connexion.dart';
import 'package:gdsport_flutter/favoris.dart';
import 'package:gdsport_flutter/homepage.dart';
import 'package:gdsport_flutter/mes_commandes.dart';
import 'package:gdsport_flutter/profil.dart';
import 'package:gdsport_flutter/register.dart';
import 'package:gdsport_flutter/modifProfil.dart';
import 'package:gdsport_flutter/widgets/CatalFem.dart';
import 'package:gdsport_flutter/widgets/CatalHom.dart';
import 'package:gdsport_flutter/widgets/CatalJun.dart';


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
        '/catalall': (BuildContext context) => const CatalAll(),
        '/catalFem': (BuildContext context) => const CatalFem(),
        '/catalHom': (BuildContext context) => const CatalHom(),
        '/catalJun': (BuildContext context) => const CatalJun(),
        '/register': (BuildContext context) => const Register(),
        '/favoris': (BuildContext context) => const FavorisPage(),
        '/profil': (BuildContext context) => const Profil(),
        '/modifProfil': (BuildContext context) => const ModifProfil(),
        '/commande': (BuildContext context) => const CommandePage(),
        '/mes-commandes': (BuildContext context) => const MesCommandePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
