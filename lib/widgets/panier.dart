import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gdsport_flutter/fonctions/panier_api.dart';
import 'package:google_fonts/google_fonts.dart';
import '../class/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:badges/badges.dart' as badges;

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

Widget infoPanier(StateSetter mystate, panier) {
  Column affichagePanier = Column(
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
                'https://s3-4674.nuage-peda.fr/GDSport/public/articles/${ajout.getArticle().getImages()[0]["name"]}',
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
                  await delArticleP(user.getToken(), ajout.getId());
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

Widget panierW(context, isLog, panier) {
  return badges.Badge(
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
              if (isLog == false) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.8, // 80% de la hauteur de l'écran
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 25, right: 25, left: 25),
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
                              child: Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Vous n'etes pas connecté"),
                                    ],
                                  ),
                                  const Padding(padding: EdgeInsets.all(10)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          child: const Text("Connectez-vous"),
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
              } else if (isLog == true && panier.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.8, // 80% de la hauteur de l'écran
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 25, right: 25, left: 25),
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
                      const Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: 10, right: 25, left: 25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.8, // 80% de la hauteur de l'écran
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 25, right: 25, left: 25),
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
                              child: infoPanier(mystate, panier)),
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
  );
}
