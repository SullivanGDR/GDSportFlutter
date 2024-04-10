import 'package:flutter/material.dart';
import 'package:gdsport_flutter/class/article.dart';
import 'package:gdsport_flutter/fonctions/article_API.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'fonctions/ArticleID_API.dart';

class ArticlePage extends StatefulWidget {
  final int articleId;
  const ArticlePage({Key? key, required this.articleId}) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  late Future<Article> _articleFuture;
  late bool _isDescriptionVisible;

  @override
  void initState() {
    super.initState();
    _articleFuture = fetchArticleById(widget.articleId);
    _isDescriptionVisible = false; // Initialisez la variable _isDescriptionVisible à false
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
                                child: Image.network(
                                  'https://s3-4674.nuage-peda.fr/GDSport/public/articles/${article.getImages()[0]}',
                                  fit: BoxFit.cover,
                                ),
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
                          _isDescriptionVisible = !_isDescriptionVisible; // Inversez la valeur de _isDescriptionVisible
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
                              "${article.description}",
                            ),
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
              return Center(
                child: Text('Échec du chargement des données'),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<Article> fetchArticleById(int id) async {
    // Vous devez implémenter la logique de récupération de l'article par son ID
    // Utilisez l'API ou le service approprié pour récupérer les données de l'article
    // Par exemple :
    return await getArticleById(id); // Supposons que vous avez une fonction getArticleById pour récupérer l'article par son ID
  }
}
