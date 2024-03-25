import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gdsport_flutter/fonctions/login_API.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';
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
    var rep =await login(email, mdp);
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
                onPressed: () async{
                  String password = _passwordController.text;
                  String email = _emailController.text;
                  User? res = await connexion(email,password);
                  if(res==null){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Erreur lors de la connexion')),
                    );
                  }else{
                    await storage.write(key: "userData", value: jsonEncode(res.toJson()));
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
            SizedBox(
              height: 50,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 60),child: Divider(),),
            Padding(padding: EdgeInsets.only(top: 15)),
            Container(alignment: Alignment.bottomCenter ,child:
            Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context, '/register');
                },
                child: Text(
                  "S'inscrire ?",
                  style: TextStyle(
                    color: Colors.black, // Couleur du texte
                    decoration: TextDecoration.underline, // Soulignement du texte
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
