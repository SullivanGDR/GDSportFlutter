import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gdsport_flutter/fonctions/login_API.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../class/user.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
TextEditingController _passwordController = TextEditingController();
TextEditingController _emailController = TextEditingController();

class Commande extends StatefulWidget {
  const Commande() : super();

  @override
  State<Commande> createState() => _CommandeState();
}

class _CommandeState extends State<Commande> {
  bool _obscureText = true;

  String? choix;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('GDSport',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Center(
              child: Text(
                'Informations de livraison',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // ou MainAxisAlignment.spaceEvenly
                children: [
                  SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Nom'),
                    ),
                  ),
                  SizedBox(
                      width: 10), // Espacement entre les deux champs de texte
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Prenom'),
                    ),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
            const Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Adresse (*)'),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // ou MainAxisAlignment.spaceEvenly
                children: [
                  SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Ville (*)'),
                    ),
                  ),
                  SizedBox(
                      width: 10), // Espacement entre les deux champs de texte
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Pays (*)'),
                    ),
                  ),
                  SizedBox(
                      width: 10), // Espacement entre les deux champs de texte
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'CP (*)'),
                    ),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 10),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Délai de livraison',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RadioListTile<String>(
                  title: Text('Livraison rapide'),
                  value: 'Livraison rapide',
                  groupValue: choix,
                  onChanged: (value) {
                    setState(() {
                      choix = value;
                    });
                  },
                  secondary: Text(
                    'Gratuit',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                RadioListTile<String>(
                  title: Text('Livraison Express'),
                  value: 'Livraison Express',
                  groupValue: choix,
                  onChanged: (value) {
                    setState(() {
                      choix = value;
                    });
                  },
                  secondary: Text(
                    '9.95€',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Container(
              height: 50,
              width: 250,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () async {},
                child: const Text(
                  'Suivant',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
