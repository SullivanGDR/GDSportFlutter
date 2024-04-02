import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gdsport_flutter/widgets/caroussel.dart';
import 'package:gdsport_flutter/widgets/drawer.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:gdsport_flutter/fonctions/login_API.dart';
import '../class/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
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
                'Mes informations ',
                style: GoogleFonts.lilitaOne(
                  textStyle: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Nom prenom : ${user.getNom()} ${user.getPrenom()}")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("email : ${user.getEmail()}")],
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'Votre adresse',
                style: GoogleFonts.lilitaOne(
                  textStyle: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "${user.getAdresse()} , ${user.getCodePostal()} , ${user.getVille()}")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("${user.getPays()}")],
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'Vos commandes',
                style: GoogleFonts.lilitaOne(
                  textStyle: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Action à effectuer lorsque le bouton est pressé
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // Bords arrondis
                          ), // Texte en noir
                          side: const BorderSide(
                              color: Colors.black), // Contour noir
                        ),
                        child: const Text(
                          'Voir les commandes',
                          style:
                              TextStyle(color: Colors.black), // Texte en noir
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/modifProfil');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Bords arrondis
                    ), // Texte en noir
                    side: const BorderSide(color: Colors.black), // Contour noir
                  ),
                  child: const Text(
                    'Modifier le profil',
                    style: TextStyle(color: Colors.black), // Texte en noir
                  ),
                ),
              ],
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
