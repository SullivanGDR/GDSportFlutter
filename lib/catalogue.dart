import 'package:flutter/material.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';

class Catalogue extends StatefulWidget {
  const Catalogue({super.key});

  @override
  State<Catalogue> createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {
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
            const Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Mot de passe'),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
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
                onPressed: () {},
                child: const Text(
                  'Se connecter',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Divider(),
            ),
            const Padding(padding: EdgeInsets.only(top: 15)),
            Container(
              alignment: Alignment.bottomCenter,
              child: const Column(
                children: [
                  Text('Créer un compte ?'),
                  Text('ou'),
                  Text('mot de passe oublié')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
