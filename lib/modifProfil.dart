import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gdsport_flutter/class/ajoutPanier.dart';
import 'package:gdsport_flutter/class/articleLight.dart';
import 'package:gdsport_flutter/fonctions/favoris_API.dart';
import 'package:gdsport_flutter/fonctions/user_API.dart';
import 'package:gdsport_flutter/fonctions/panier_api.dart';
import 'package:gdsport_flutter/widgets/caroussel.dart';
import 'package:gdsport_flutter/widgets/drawer.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:gdsport_flutter/fonctions/login_API.dart';
import '../class/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:badges/badges.dart' as badges;

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

TextEditingController _emailController = TextEditingController();
TextEditingController _nomController = TextEditingController();
TextEditingController _prenomController = TextEditingController();
TextEditingController _adresseController = TextEditingController();
TextEditingController _villeController = TextEditingController();
TextEditingController _paysController = TextEditingController();
TextEditingController _cpController = TextEditingController();

class ModifProfil extends StatefulWidget {
  const ModifProfil({super.key});

  @override
  State<ModifProfil> createState() => _ModifProfilState();
}

class _ModifProfilState extends State<ModifProfil> {
  bool _isLoading = true;
  bool _isLog = false;
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  User user = User(0, 0, "_email", "_token", "_prenom", "_nom", "_adresse",
      "_ville", "_codePostal", "pays");

  @override
  void initState() {
    super.initState();
    chargement();
  }

  void chargement() async {
    var value = await storage.read(key: "userData");
    if (value != null) {
      user = User.fromJson(jsonDecode(value));
      _isLog = await isLogin(user.getToken(), user.getId());
      if (_isLog == true) {
        try {
          _emailController.text = user.getEmail();
          _nomController.text = user.getNom();
          _prenomController.text = user.getPrenom();
          _adresseController.text = user.getAdresse().toString();
          _villeController.text = user.getVille().toString();
          _cpController.text = user.getCodePostal().toString();
          _paysController.text = user.getPays().toString();
        } catch (e) {
          print("Une erreur s'est produite lors du décodage json : $e");
        }
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? _loading() : _buildContent(),
    );
  }

  Widget _buildContent() {
    return Scaffold(
      appBar: appBar(context),
      drawer: appDrawer(context, _isLog, user),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // CAROUSEL D'INFORMATIONS
            carousel(context),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'Modification du profil',
                style: GoogleFonts.lilitaOne(
                  textStyle: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 15),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
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
                            controller: _nomController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(), labelText: 'Nom'),
                          ),
                        ),
                        SizedBox(
                            width:
                                10), // Espacement entre les deux champs de texte
                        Expanded(
                          child: TextField(
                            controller: _prenomController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Prenom'),
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
                          border: OutlineInputBorder(), labelText: 'Adresse'),
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
                                border: OutlineInputBorder(),
                                labelText: 'Ville'),
                          ),
                        ),
                        SizedBox(
                            width:
                                10), // Espacement entre les deux champs de texte
                        Expanded(
                          child: TextField(
                            controller: _paysController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Pays'),
                          ),
                        ),
                        SizedBox(
                            width:
                                10), // Espacement entre les deux champs de texte
                        Expanded(
                          child: TextField(
                            controller: _cpController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(), labelText: 'CP'),
                          ),
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
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
                        String email = _emailController.text;
                        String nom = _nomController.text;
                        String prenom = _prenomController.text;
                        String adresse = _adresseController.text;
                        String ville = _villeController.text;
                        String pays = _paysController.text;
                        String cp = _cpController.text;
                        var rep = await modifProfil(
                            user.getToken(),
                            user.getId(),
                            nom,
                            prenom,
                            email,
                            adresse,
                            ville,
                            pays,
                            cp);
                        await resetDataUserLocal(user.getToken(), user.getId());
                        if (rep == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Compte modifié avec succès')),
                          );
                          Navigator.popAndPushNamed(context, '/accueil');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Erreur lors de la modification du compte')),
                          );
                        }
                      },
                      child: Text(
                        "Modifier",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _loading() {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // CAROUSEL D'INFORMATIONS
          carousel(context),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'FAVORIS (0)',
              style: GoogleFonts.lilitaOne(
                textStyle: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: const SizedBox(
                    height: 90,
                    width: double.infinity, // Prend toute la largeur disponible
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey, // Couleur gris
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: const SizedBox(
                    height: 90,
                    width: double.infinity, // Prend toute la largeur disponible
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey, // Couleur gris
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: const SizedBox(
                    height: 90,
                    width: double.infinity, // Prend toute la largeur disponible
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey, // Couleur gris
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: const SizedBox(
                    height: 90,
                    width: double.infinity, // Prend toute la largeur disponible
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey, // Couleur gris
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: const SizedBox(
                    height: 90,
                    width: double.infinity, // Prend toute la largeur disponible
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey, // Couleur gris
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: const SizedBox(
                    height: 90,
                    width: double.infinity, // Prend toute la largeur disponible
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey, // Couleur gris
                      ),
                    ),
                  ),
                ),
              ]))
        ],
      ),
    );
  }
}
