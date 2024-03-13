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

class Connexion extends StatefulWidget {
  const Connexion() : super();

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  Future<User?> connexion(email, mdp) async {
    var rep = await login(email, mdp);
    return rep;
  }

  bool _obscureText = true;

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
            const Padding(padding: EdgeInsets.only(top: 50)),
            const Center(
              child: Text(
                'Connexion',
                style: TextStyle(color: Colors.black, fontSize: 50),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Mot de passe',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureText =
                            !_obscureText; // Inverse l'état d'obscurcissement du texte
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Pas encore inscrit ? ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/register");
                  },
                  child: const Text(
                    'Inscrivez-vous !',
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
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
                onPressed: () async {
                  String password = _passwordController.text;
                  String email = _emailController.text;
                  User? res = await connexion(email, password);
                  if (res == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Erreur lors de la connexion')),
                    );
                  } else {
                    await storage.write(
                        key: "userData", value: jsonEncode(res.toJson()));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Vous êtes connecter')),
                    );
                    Navigator.popAndPushNamed(context, '/accueil');
                  }
                },
                child: const Text(
                  'Se connecter',
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
