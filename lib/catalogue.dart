import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gdsport_flutter/class/ajoutPanier.dart';
import 'package:gdsport_flutter/class/article.dart';
import 'package:gdsport_flutter/fonctions/article_API.dart';
import 'package:gdsport_flutter/fonctions/panier_api.dart';
import 'package:gdsport_flutter/widgets/carousels.dart';
import 'package:gdsport_flutter/widgets/drawer.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';
import 'package:gdsport_flutter/widgets/panier.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gdsport_flutter/fonctions/login_API.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shimmer/shimmer.dart';
import '../class/user.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);


class Catalogue extends StatefulWidget {
  const Catalogue({super.key});

  @override
  State<Catalogue> createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {

  List<Article> _articlesTendance = [];
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  bool _isLoading = true;
  bool _isLog = false;
  User user = User(0, 0, "_email", "_token", "_prenom", "_nom", "_adresse",
      "_ville", "_codePostal", "_pays");
  List<AjoutPanier> panier = [];

  @override
  void initState() {
    super.initState();
    chargement();
  }

  void chargement() async {
    _articlesTendance = await initListArticleTendance(_articlesTendance);
    var value = await storage.read(key: "userData");
    if (value != null) {
      user = User.fromJson(jsonDecode(value));
      _isLog = await isLogin(user.getToken(), user.getId());
      if (_isLog == true) {
        try {
          panier = await getPanier(user.getToken(), user.getId(), panier);
        } catch (e) {
          if (kDebugMode) {
            print("Une erreur s'est produite lors du décodage json : $e");
          }
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      'Tendances',
                      style: GoogleFonts.lilitaOne(
                        textStyle: const TextStyle(letterSpacing: .5, fontSize: 23),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _articlesTendance.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              width: 200,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    'https://s3-4674.nuage-peda.fr/GDSport/public/articles/${_articlesTendance[index].getImages()[0]}',
                                    width: 250,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(
                                      height:
                                      10),
                                  Text(
                                    _articlesTendance[index].designation,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${_articlesTendance[index].prix} €',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Bouton "Afficher tout" avec une flèche
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Espacement
                        const Spacer(),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.popAndPushNamed(context, '/catalall');
                          },
                          label: const Text(
                            'Afficher tout',
                            style: TextStyle(color: Colors.black), // Couleur du texte
                          ),
                          icon: const Icon(Icons.arrow_forward, color: Colors.black), // Couleur de l'icône
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, // Couleur de fond
                            side: const BorderSide(color: Colors.black), // Couleur du contour
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: InkWell(
                      onTap: () {
                        // Action à effectuer lors du clic sur l'encre
                      },
                      child: Center(
                        child: Card(
                          color: Colors.grey[200],
                          elevation: 5,
                          shape: const RoundedRectangleBorder(),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.image),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 100,
                                  padding: const EdgeInsets.all(10),
                                  child: const Center(
                                    child: Text(
                                      'Hauts',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: InkWell(
                      onTap: () {
                        // Action à effectuer lors du clic sur l'encre
                      },
                      child: Center(
                        child: Card(
                          color: Colors.grey[200],
                          elevation: 5,
                          shape: const RoundedRectangleBorder(),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.image),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 100,
                                  padding: const EdgeInsets.all(10),
                                  child: const Center(
                                    child: Text(
                                      'Bas',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: InkWell(
                      onTap: () {
                        // Action à effectuer lors du clic sur l'encre
                      },
                      child: Center(
                        child: Card(
                          color: Colors.grey[200],
                          elevation: 5,
                          shape: const RoundedRectangleBorder(),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.image),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 100,
                                  padding: const EdgeInsets.all(10),
                                  child: const Center(
                                    child: Text(
                                      'Vestes et manteaux',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: InkWell(
                      onTap: () {
                        // Action à effectuer lors du clic sur l'encre
                      },
                      child: Center(
                        child: Card(
                          color: Colors.grey[200],
                          elevation: 5,
                          shape: const RoundedRectangleBorder(),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.image),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 100,
                                  padding: const EdgeInsets.all(10),
                                  child: const Center(
                                    child: Text(
                                      'Pyjamas et vêtements confort',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: panierW(context, _isLog, panier));
  }


  Widget _loading() {
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // CAROUSEL D'INFORMATIONS
            CarouselSliderPub(context),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TENDANCES',
                    style: GoogleFonts.lilitaOne(
                      textStyle:
                      const TextStyle(letterSpacing: .5, fontSize: 25),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height:
                    250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          width:
                          180,
                          margin: const EdgeInsets.all(10),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 200,
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 10,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(height: 5),
                                            Container(
                                              width: double.infinity,
                                              height: 10,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
                // Bouton "Afficher tout" avec une flèche
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Espacement
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/catalall');
                        },
                        label: const Text(
                          'Afficher tout',
                          style: TextStyle(color: Colors.black), // Couleur du texte
                        ),
                        icon: const Icon(Icons.arrow_forward, color: Colors.black), // Couleur de l'icône
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Couleur de fond
                          side: const BorderSide(color: Colors.black), // Couleur du contour
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: InkWell(
                    onTap: () {
                      // Action à effectuer lors du clic sur l'encre
                    },
                    child: Center(
                      child: Card(
                        color: Colors.grey[200],
                        elevation: 5,
                        shape: const RoundedRectangleBorder(),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(),
                                ),
                                child: const Center(
                                  child: Icon(Icons.image),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 100,
                                padding: const EdgeInsets.all(10),
                                child: const Center(
                                  child: Text(
                                    'Hauts',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: InkWell(
                    onTap: () {
                      // Action à effectuer lors du clic sur l'encre
                    },
                    child: Center(
                      child: Card(
                        color: Colors.grey[200],
                        elevation: 5,
                        shape: const RoundedRectangleBorder(),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(),
                                ),
                                child: const Center(
                                  child: Icon(Icons.image),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 100,
                                padding: const EdgeInsets.all(10),
                                child: const Center(
                                  child: Text(
                                    'Bas',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: InkWell(
                    onTap: () {
                      // Action à effectuer lors du clic sur l'encre
                    },
                    child: Center(
                      child: Card(
                        color: Colors.grey[200],
                        elevation: 5,
                        shape: const RoundedRectangleBorder(),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(),
                                ),
                                child: const Center(
                                  child: Icon(Icons.image),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 100,
                                padding: const EdgeInsets.all(10),
                                child: const Center(
                                  child: Text(
                                    'Vestes et manteaux',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: InkWell(
                    onTap: () {
                      // Action à effectuer lors du clic sur l'encre
                    },
                    child: Center(
                      child: Card(
                        color: Colors.grey[200],
                        elevation: 5,
                        shape: const RoundedRectangleBorder(),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(),
                                ),
                                child: const Center(
                                  child: Icon(Icons.image),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 100,
                                padding: const EdgeInsets.all(10),
                                child: const Center(
                                  child: Text(
                                    'Pyjamas et vêtements confort',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ),
      );
  }
}
