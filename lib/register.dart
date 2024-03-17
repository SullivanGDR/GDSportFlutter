import 'package:flutter/material.dart';
import 'package:gdsport_flutter/fonctions/register_API.dart';

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
            const Padding(padding: EdgeInsets.only(top: 10)),
            const Center(
              child: Text(
                'Inscrivez-vous',
                style: TextStyle(color: Colors.black, fontSize: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
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
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // ou MainAxisAlignment.spaceEvenly
              children: [
                const SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    controller: _nomController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Nom'),
                  ),
                ),
                const SizedBox(
                    width: 10), // Espacement entre les deux champs de texte
                Expanded(
                  child: TextField(
                    controller: _prenomController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Prenom'),
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _adresseController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Adresse (*)'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    controller: _villeController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Ville (*)'),
                  ),
                ),
                const SizedBox(
                    width: 10), // Espacement entre les deux champs de texte
                Expanded(
                  child: TextField(
                    controller: _paysController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Pays (*)'),
                  ),
                ),
                const SizedBox(
                    width: 10), // Espacement entre les deux champs de texte
                Expanded(
                  child: TextField(
                    controller: _cpController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'CP (*)'),
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
            const SizedBox(height: 40),
            const Text("(*) : Champs non obligatoires."),
            const SizedBox(height: 5),
            const Divider(
              indent: 150,
              endIndent: 150,
              color: Color.fromRGBO(0, 0, 0, 0.10),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Déjà inscrit ? ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/connexion");
                  },
                  child: const Text(
                    'Connexion',
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
                          backgroundColor: Colors.red,
                          content:
                              Text('Erreur lors de la création du compte')),
                    );
                  }
                },
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
