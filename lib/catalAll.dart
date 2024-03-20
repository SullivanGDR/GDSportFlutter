import 'package:flutter/material.dart';
import 'package:gdsport_flutter/class/article.dart';
import 'package:gdsport_flutter/fonctions/article_API.dart';
import 'package:gdsport_flutter/widgets/drawer.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';
import 'package:google_fonts/google_fonts.dart';

class CatalAll extends StatefulWidget {
  const CatalAll({super.key});

  @override
  State<CatalAll> createState() => _CatalAllState();
}

class _CatalAllState extends State<CatalAll> {
  List<Article> _articles = [];
  List<Article> _filteredArticles = [];
  Set<String> _genres = {'Tous'};
  Set<String> _types = {'Tous'};
  String _selectedGenre = 'Tous';
  String _selectedType = 'Tous';

  @override
  void initState() {
    super.initState();
    initArticles();
  }

  void initArticles() async {
    // Simuler la récupération des articles
    // Vous devez remplacer ceci par votre fonction réelle d'appel API
    // et assurez-vous que vos articles ont les propriétés 'genre' et 'type'
    _articles = await initListArticle([]);
    // Extraction des genres et des types uniques
    _articles.forEach((article) {
      _genres.add(article.genre);
      _types.add(article.type);
    });
    _filteredArticles = _articles;
    setState(() {});
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
      drawer: appDrawer(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                    items:
                        _genres.map<DropdownMenuItem<String>>((String value) {
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
                    items: _types.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
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
                    // Action à effectuer lors du clic sur l'article
                  },
                  child: GridTile(
                    child: Image.network(
                      'https://s3-4674.nuage-peda.fr/GDSport/public/articles/${article.getImages()[0]}',
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
    );
  }
}
