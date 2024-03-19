import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gdsport_flutter/class/article.dart';
import 'package:gdsport_flutter/fonctions/article_API.dart';
import 'package:gdsport_flutter/widgets/drawer.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';


class CatalAll extends StatefulWidget {
  const CatalAll({super.key});

  @override
  State<CatalAll> createState() => _CatalAllState();
}

class _CatalAllState extends State<CatalAll> {
  List<Article> _articles = [];
  List<Article> _filteredArticles = [];
  String _selectedFilter = 'Tous';

  @override
  void initState() {
    super.initState();
    // Initiez vos articles ici (en utilisant initListArticle ou initListArticleTendance)
    initArticles();
  }

  void initArticles() async {
    _articles = await initListArticle([]); // ou initListArticleTendance
    _filteredArticles = _articles;
    setState(() {});
  }

  void filterArticles(String filter) {
    if (filter == 'Tous') {
      _filteredArticles = _articles;
    } else {
      _filteredArticles = _articles.where((article) {
        return article.genre == filter || article.type == filter;
      }).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles', style: GoogleFonts.lilitaOne()),
        actions: [
          DropdownButton<String>(
            value: _selectedFilter,
            items: <String>['Tous', 'Genre 1', 'Type 1', 'Genre 2', 'Type 2'] // Remplacez par vos genres et types
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedFilter = value;
                  filterArticles(value);
                });
              }
            },
          ),
        ],
      ),
      body: GridView.builder(
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
            child: Column(
              children: [
                Image.network(
                  article.images.isNotEmpty ? article.images[0] : 'https://example.com/default.jpg',
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Text(article.designation),
                Text('${article.prix} €'),
              ],
            ),
          );
        },
      ),
    );
  }
}
