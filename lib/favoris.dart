import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gdsport_flutter/class/ajoutPanier.dart';
import 'package:gdsport_flutter/class/article.dart';
import 'package:gdsport_flutter/fonctions/article_API.dart';
import 'package:gdsport_flutter/fonctions/panier_api.dart';
import 'package:gdsport_flutter/widgets/drawer.dart';
import 'package:gdsport_flutter/widgets/infoPanier.dart';
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

class FavorisPage extends StatefulWidget {
  const FavorisPage({super.key});

  @override
  State<FavorisPage> createState() => _FavorisPageState();
}

class _FavorisPageState extends State<FavorisPage> {
  bool _isLoading = true;
  bool _isLog = false;
  String nameUser = "";
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  List<AjoutPanier> panier = [];

  @override
  void initState() {
    super.initState();
    chargement();
  }

  void chargement() async {
    var value = await storage.read(key: "userData");
    if (value != null) {
      User user = User.fromJson(jsonDecode(value));
      _isLog = await isLogin(user.getToken(), user.getId());
      if (_isLog == true) {
        try {
          nameUser = '${user.getNom()} ${user.getPrenom()}';
          panier = await getPanier(user.getToken(), user.getId(), panier);
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
        drawer: appDrawer(context, _isLog, nameUser),
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
                padding: EdgeInsets.all(15),
                child: Text(
                  'FAVORIS (0)',
                  style: GoogleFonts.lilitaOne(
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            SizedBox(
                              width: 90,
                              height: 90,
                              child: Image.asset(
                                'assets/images/image_article_test.webp',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Adidas Campus 00s",
                                    style: GoogleFonts.lilitaOne(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text("Taille : 30 EU"),
                                  Text('100 €'),
                                ],
                              ),
                            ),
                            const Icon(Icons.close),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            SizedBox(
                              width: 90,
                              height: 90,
                              child: Image.asset(
                                'assets/images/image_article_test.webp',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Adidas Campus 00s",
                                    style: GoogleFonts.lilitaOne(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text("Taille : 30 EU"),
                                  Text('100 €'),
                                ],
                              ),
                            ),
                            const Icon(Icons.close),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            SizedBox(
                              width: 90,
                              height: 90,
                              child: Image.asset(
                                'assets/images/image_article_test.webp',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Adidas Campus 00s",
                                    style: GoogleFonts.lilitaOne(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text("Taille : 30 EU"),
                                  Text('100 €'),
                                ],
                              ),
                            ),
                            const Icon(Icons.close),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            SizedBox(
                              width: 90,
                              height: 90,
                              child: Image.asset(
                                'assets/images/image_article_test.webp',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Adidas Campus 00s",
                                    style: GoogleFonts.lilitaOne(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text("Taille : 30 EU"),
                                  Text('100 €'),
                                ],
                              ),
                            ),
                            const Icon(Icons.close),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            SizedBox(
                              width: 90,
                              height: 90,
                              child: Image.asset(
                                'assets/images/image_article_test.webp',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Adidas Campus 00s",
                                    style: GoogleFonts.lilitaOne(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text("Taille : 30 EU"),
                                  Text('100 €'),
                                ],
                              ),
                            ),
                            const Icon(Icons.close),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            SizedBox(
                              width: 90,
                              height: 90,
                              child: Image.asset(
                                'assets/images/image_article_test.webp',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Adidas Campus 00s",
                                    style: GoogleFonts.lilitaOne(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text("Taille : 30 EU"),
                                  Text('100 €'),
                                ],
                              ),
                            ),
                            const Icon(Icons.close),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            SizedBox(
                              width: 90,
                              height: 90,
                              child: Image.asset(
                                'assets/images/image_article_test.webp',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Adidas Campus 00s",
                                    style: GoogleFonts.lilitaOne(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text("Taille : 30 EU"),
                                  Text('100 €'),
                                ],
                              ),
                            ),
                            const Icon(Icons.close),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            SizedBox(
                              width: 90,
                              height: 90,
                              child: Image.asset(
                                'assets/images/image_article_test.webp',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Adidas Campus 00s",
                                    style: GoogleFonts.lilitaOne(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text("Taille : 30 EU"),
                                  Text('100 €'),
                                ],
                              ),
                            ),
                            const Icon(Icons.close),
                          ],
                        ),
                      ),
                      SizedBox(height: 100)
                    ],
                  ))
            ],
          ),
        ),
        floatingActionButton: badges.Badge(
          badgeContent: Text(
            "${panier.length}",
            style: TextStyle(color: Colors.white),
          ),
          badgeStyle: badges.BadgeStyle(
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
                  return SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.8, // 80% de la hauteur de l'écran
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 25, right: 25, left: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                child: infoPanier(panier)),
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
                                  side: const BorderSide(color: Colors.black),
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
            padding: EdgeInsets.all(15),
            child: Text(
              'FAVORIS (0)',
              style: GoogleFonts.lilitaOne(
                textStyle: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 90,
                    width: double.infinity, // Prend toute la largeur disponible
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey, // Couleur gris
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 90,
                    width: double.infinity, // Prend toute la largeur disponible
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey, // Couleur gris
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 90,
                    width: double.infinity, // Prend toute la largeur disponible
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey, // Couleur gris
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 90,
                    width: double.infinity, // Prend toute la largeur disponible
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey, // Couleur gris
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 90,
                    width: double.infinity, // Prend toute la largeur disponible
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey, // Couleur gris
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
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
