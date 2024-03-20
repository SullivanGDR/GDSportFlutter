import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gdsport_flutter/class/ajoutPanier.dart';
import 'package:gdsport_flutter/class/articleLight.dart';
import 'package:gdsport_flutter/fonctions/favoris_API.dart';
import 'package:gdsport_flutter/fonctions/user_API.dart';
import 'package:gdsport_flutter/fonctions/panier_api.dart';
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
  String nameUser = "";
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  List<AjoutPanier> panier = [];
  List<ArticleLight> favoris = [];
  int nbFav = 0;
  User user = User(0, "_email", "_token", "_prenom", "_nom", "_adresse",
      "_ville", "_codePostal", "pays", []);

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
          nameUser = '${user.getNom()} ${user.getPrenom()}';
          panier = await getPanier(user.getToken(), user.getId(), panier);
          favoris = await getFavoris(user.getToken(), user.getId(), favoris);
          nbFav = favoris.length;
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

  Widget infoPanier(StateSetter mystate) {
    Column affichagePanier = const Column(
      children: <Widget>[],
    );
    for (var ajout in panier) {
      affichagePanier.children.add(
        InkWell(
          onTap: () {},
          child: Row(
            children: [
              SizedBox(
                width: 90,
                height: 90,
                child: Image.network(
                  'https://s3-4672.nuage-peda.fr/GDSport/public/articles/${ajout.getArticle().getImages()[0]["name"]}',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ajout.getArticle().getDesignation(),
                      style: GoogleFonts.lilitaOne(
                        textStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Text("Taille : "),
                    Text('${ajout.getArticle().getPrix()} €'),
                    Row(
                      children: [
                        const Text("Quantité : "),
                        InkWell(
                            child: const Icon(Icons.remove_circle_outline),
                            onTap: () async {
                              if (ajout.getQte() > 1) {
                                var value = await storage.read(key: "userData");
                                if (value != null) {
                                  User user = User.fromJson(jsonDecode(value));
                                  await supQte(user.getToken(), ajout.getId(),
                                      ajout.getQte());
                                  panier.clear();
                                  panier = await getPanier(
                                      user.getToken(), user.getId(), panier);
                                  mystate(
                                      () {}); // Appel de la fonction updatePanier
                                }
                              } else {
                                // Autre logique
                              }
                            }),
                        Text(" ${ajout.getQte()} "),
                        InkWell(
                            child: const Icon(Icons.add_circle_outline),
                            onTap: () async {
                              var value = await storage.read(key: "userData");
                              if (value != null) {
                                User user = User.fromJson(jsonDecode(value));
                                await addQte(user.getToken(), ajout.getId(),
                                    ajout.getQte());
                                panier.clear();
                                panier = await getPanier(
                                    user.getToken(), user.getId(), panier);
                                mystate(() {});
                              }
                            }),
                      ],
                    )
                  ],
                ),
              ),
              InkWell(
                child: const Icon(Icons.delete_outline),
                onTap: () async {
                  var value = await storage.read(key: "userData");
                  if (value != null) {
                    User user = User.fromJson(jsonDecode(value));
                    await delArticle(user.getToken(), ajout.getId());
                    panier.clear();
                    panier =
                        await getPanier(user.getToken(), user.getId(), panier);
                    mystate(() {});
                  }
                },
              ),
            ],
          ),
        ),
      );
      affichagePanier.children.add(const SizedBox(height: 8));
    }
    return affichagePanier;
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
        drawer: appDrawer(context, _isLog, nameUser, nbFav),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // CAROUSEL D'INFORMATIONS
              CarouselSlider(
                items: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black87,
                    child: const Center(
                      child: Text(
                        'SOLDES DERNIERES DEMARQUES',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black87,
                    child: const Center(
                      child: Text(
                        'RESTOCK DES AF1',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black87,
                    child: const Center(
                      child: Text(
                        'OFFRES ETUDIANTES',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
                options: CarouselOptions(
                  height: 50,
                  autoPlay: true,
                  viewportFraction: 1,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Modification du profil',
                  style: GoogleFonts.lilitaOne(
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 20),
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
                                  border: OutlineInputBorder(),
                                  labelText: 'Nom'),
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
                                  border: OutlineInputBorder(),
                                  labelText: 'CP'),
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
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
                          await resetDataUserLocal(
                              user.getToken(), user.getId());
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
        floatingActionButton: badges.Badge(
          badgeContent: Text(
            "${panier.length}",
            style: const TextStyle(color: Colors.white),
          ),
          badgeStyle: const badges.BadgeStyle(
            badgeColor: Colors.black,
            padding: EdgeInsets.all(8),
            elevation: 0,
          ),
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.white,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter mystate) {
                    if (_isLog == false) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.8, // 80% de la hauteur de l'écran
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 25, right: 25, left: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'PANIER',
                                    style: GoogleFonts.lilitaOne(
                                      textStyle: const TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                              indent: 50,
                              endIndent: 50,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, right: 25, left: 25),
                                    child: Column(
                                      children: [
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Vous n'etes pas connecté"),
                                          ],
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.all(10)),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                                child: const Text(
                                                    "Connectez-vous"),
                                                onTap: () {
                                                  Navigator.popAndPushNamed(
                                                      context, "/connexion");
                                                })
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            Container(
                              width: double
                                  .infinity, // Prend toute la largeur de l'écran
                              color: Colors.white, // Fond blanc pour le bouton
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    elevation: 0,
                                    minimumSize: const Size(250, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side:
                                          const BorderSide(color: Colors.black),
                                    ),
                                  ),
                                  child: const Text(
                                    'Commander',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (_isLog == true && panier.isEmpty) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.8, // 80% de la hauteur de l'écran
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 25, right: 25, left: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'PANIER',
                                    style: GoogleFonts.lilitaOne(
                                      textStyle: const TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                              indent: 50,
                              endIndent: 50,
                            ),
                            const Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 10, right: 25, left: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Votre panier est vide"),
                                      ],
                                    )),
                              ),
                            ),
                            Container(
                              width: double
                                  .infinity, // Prend toute la largeur de l'écran
                              color: Colors.white, // Fond blanc pour le bouton
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    elevation: 0,
                                    minimumSize: const Size(250, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side:
                                          const BorderSide(color: Colors.black),
                                    ),
                                  ),
                                  child: const Text(
                                    'Commander',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.8, // 80% de la hauteur de l'écran
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 25, right: 25, left: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'PANIER',
                                    style: GoogleFonts.lilitaOne(
                                      textStyle: const TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                              indent: 50,
                              endIndent: 50,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, right: 25, left: 25),
                                    child: infoPanier(mystate)),
                              ),
                            ),
                            Container(
                              width: double
                                  .infinity, // Prend toute la largeur de l'écran
                              color: Colors.white, // Fond blanc pour le bouton
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    elevation: 0,
                                    minimumSize: const Size(250, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side:
                                          const BorderSide(color: Colors.black),
                                    ),
                                  ),
                                  child: const Text(
                                    'Commander',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  });
                },
              );
            },
            tooltip: 'Panier',
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 10,
            child: const Icon(Icons.shopping_bag_outlined),
          ),
        ));
  }

  Widget _loading() {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // CAROUSEL D'INFORMATIONS
          CarouselSlider(
            items: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black87,
                child: const Center(
                  child: Text(
                    'SOLDES DERNIERES DEMARQUES',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black87,
                child: const Center(
                  child: Text(
                    'RESTOCK DES AF1',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black87,
                child: const Center(
                  child: Text(
                    'OFFRES ETUDIANTES',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ),
            ],
            options: CarouselOptions(
              height: 50,
              autoPlay: true,
              viewportFraction: 1,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
            ),
          ),
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
