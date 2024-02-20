import 'package:flutter/material.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 50)),
            Center(child: Text(
              'Inscrivez-vous',
              style: TextStyle(color: Colors.black, fontSize: 50),
            ),),
            Padding(padding: EdgeInsets.only(top: 30)),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // ou MainAxisAlignment.spaceEvenly
                children: [
                  SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nom'
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Espacement entre les deux champs de texte
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Prenom'
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Adresse (*)'),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () {

                },
                child: Text(
                  'Se connecter',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 60),child: Divider(),),
            Padding(padding: EdgeInsets.only(top: 15)),
            Container(alignment: Alignment.bottomCenter ,child:
            Column(children: [
              Text('Créer un compte ?'),
              Text('ou'),
              Text('mot de passe oublié')],),)

          ],
        ),
      ),
    );
  }
}
