import 'package:flutter/material.dart';
import 'package:gdsport_flutter/fonctions/login_API.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';

// Déclarez les contrôleurs en dehors de la classe _ConnexionState
TextEditingController _passwordController = TextEditingController();
TextEditingController _emailController = TextEditingController();

class Connexion extends StatefulWidget {
  const Connexion() : super();

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  void connexion(email, mdp) async {
    await login(email, mdp);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
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
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Mot de passe'),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () {
                  String password = _passwordController.text;
                  String email = _emailController.text;
                  connexion(email,password);
                },
                child: const Text(
                  'Se connecter',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            // Le reste de votre code...
          ],
        ),
      ),
    );
  }
}
