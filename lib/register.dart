import 'package:flutter/material.dart';
import 'package:gdsport_flutter/fonctions/register_API.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';

TextEditingController _passwordController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _nomController = TextEditingController();
TextEditingController _prenomController = TextEditingController();
TextEditingController _adresseController = TextEditingController();
TextEditingController _villeController = TextEditingController();
TextEditingController _paysController = TextEditingController();
TextEditingController _cpController = TextEditingController();

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Future<bool> inscription(
      email, mdp, nom, prenom, adresse, ville, cp, pays) async {
    var rep = await register(email, mdp, nom, prenom, adresse, ville, cp, pays);
    return rep;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 10)),
            Center(
              child: Text(
                'Inscrivez-vous',
                style: TextStyle(color: Colors.black, fontSize: 50),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Mot de passe'),
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
                      controller: _nomController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Nom'),
                    ),
                  ),
                  SizedBox(
                      width: 10), // Espacement entre les deux champs de texte
                  Expanded(
                    child: TextField(
                      controller: _prenomController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Prenom'),
                    ),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _adresseController,
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
                      controller: _villeController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Ville (*)'),
                    ),
                  ),
                  SizedBox(
                      width: 10), // Espacement entre les deux champs de texte
                  Expanded(
                    child: TextField(
                      controller: _paysController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Pays (*)'),
                    ),
                  ),
                  SizedBox(
                      width: 10), // Espacement entre les deux champs de texte
                  Expanded(
                    child: TextField(
                      controller: _cpController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'CP (*)'),
                    ),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text("(*) : Champs non obligatoires."),
            Padding(padding: EdgeInsets.only(top: 30)),
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
                  String nom = _nomController.text;
                  String prenom = _prenomController.text;
                  String adresse = _adresseController.text;
                  String ville = _villeController.text;
                  String pays = _paysController.text;
                  String cp = _cpController.text;
                  var rep = await inscription(
                      email, password, nom, prenom, adresse, ville, cp, pays);
                  if (rep == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Compte créé avec succès')),
                    );
                    Navigator.popAndPushNamed(context, '/connexion');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Erreur lors de la création du compte')),
                    );
                  }
                },
                child: Text(
                  "S'inscrire",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Divider(),
            ),
            Padding(padding: EdgeInsets.only(top: 15)),
            Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/connexion');
                    },
                    child: Text(
                      'Se connecter ?',
                      style: TextStyle(
                        color: Colors.black, // Couleur du texte
                        decoration:
                            TextDecoration.underline, // Soulignement du texte
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
