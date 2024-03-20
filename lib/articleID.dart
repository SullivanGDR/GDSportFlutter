import 'package:flutter/material.dart';
import 'package:gdsport_flutter/class/article.dart';
import 'package:gdsport_flutter/fonctions/article_API.dart';
import 'package:gdsport_flutter/widgets/drawer.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gdsport_flutter/articleID.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ArticlePage extends StatefulWidget {
  final int articleId;
  const ArticlePage({Key? key, required this.articleId}) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  late Future<Article> _articleFuture;
  bool _isDescriptionVisible = false;

  @override
  void initState() {
    super.initState();
    _articleFuture = fetchArticleById(widget
        .articleId); // Assurez-vous que cette fonction existe et est correctement implémentée pour récupérer un Article
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de l\'article'),
      ),
      body: FutureBuilder<Article>(
        future: _articleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Article article = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        ),
                        items: article.images.map((image) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                child: Image.network(image, fit: BoxFit.cover),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        article.designation,
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _isDescriptionVisible = !isExpanded;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text('Description'),
                            );
                          },
                          body: ListTile(
                            title: Text(
                                "${article.description}\n\nID: ${article.id}"),
                          ),
                          isExpanded: _isDescriptionVisible,
                        ),
                      ],
                    ),
                    // Ajoutez ici d'autres détails de l'article comme les tailles, avis, etc.
                  ],
                ),
              );
            } else {
              return Text('Aucune donnée');
            }
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  // Vous devez implémenter cette fonction pour récupérer les détails de l'article
  Future<Article> fetchArticleById(int id) async {
    // Votre logique de récupération d'article ici
    throw UnimplementedError();
  }
}
