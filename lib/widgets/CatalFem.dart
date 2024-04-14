import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:gdsport_flutter/widgets/panier.dart';
import 'package:gdsport_flutter/class/user.dart';
import 'package:gdsport_flutter/articleID.dart';
import 'package:gdsport_flutter/class/article.dart';
import 'package:gdsport_flutter/widgets/drawer.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';
import 'package:gdsport_flutter/class/ajoutPanier.dart';
import 'package:gdsport_flutter/fonctions/login_API.dart';
import 'package:gdsport_flutter/fonctions/panier_api.dart';
import 'package:gdsport_flutter/fonctions/article_API.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);

class CatalFem extends StatefulWidget {
  const CatalFem({super.key});

  @override
  State<CatalFem> createState() => _CatalFemState();
}

class _CatalFemState extends State<CatalFem> {
  List<Article> _articles = [];
  List<Article> _filteredArticles = [];
  Set<String> _genres = {'Tous','Femme'};
  Set<String> _types = {'Tous'};
  String _selectedGenre = 'Femme'; // Changé à 'Femme'
  String _selectedType = 'Tous';
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  bool _isLoading = true;
  bool _isLog = false;
  User user = User(0, 0, "_email", "_token", "_prenom", "_nom", "_adresse", "_ville", "_codePostal", "_pays");
  List<AjoutPanier> panier = [];

  @override
  void initState() {
    super.initState();
    chargement();
  }

  void chargement() async {
    _articles = await initListArticle([]);
    _articles.forEach((article) {
      _genres.add(article.genre);
      _types.add(article.type);
    });
    // Appliquer le filtre "Femme" dès le chargement
    filterArticles();
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

  void filterArticles() {
    List<Article> tempArticles = _articles.where((article) {
      return (_selectedGenre == 'Tous' || article.genre == _selectedGenre) &&
          (_selectedType == 'Tous' || article.type == _selectedType);
    }).toList();
    setState(() {
      _filteredArticles = tempArticles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      drawer: appDrawer(context, _isLog, user),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedGenre,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedGenre = newValue!;
                              filterArticles();
                            });
                          },
                          items: _genres.map<DropdownMenuItem<String>>((
                              String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(width: 20), // Add some spacing
                      Expanded(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedType,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedType = newValue!;
                              filterArticles();
                            });
                          },
                          items: _types.map<DropdownMenuItem<String>>((
                              String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: _filteredArticles.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final article = _filteredArticles[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ArticlePage(articleId: article.id),
                        ),
                      );
                    },
                    child: GridTile(
                      child: Image.network(
                        'https://s3-4674.nuage-peda.fr/GDSport/public/articles/${article
                            .getImages()[0]}',
                        fit: BoxFit.cover,
                      ),
                      footer: GridTileBar(
                        backgroundColor: Colors.black45,
                        title: Text(
                          article.designation,
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          '${article.prix} €',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: panierW(context, _isLog, panier));
  }
}