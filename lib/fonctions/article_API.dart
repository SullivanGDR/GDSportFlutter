import 'dart:convert';
import 'package:http/http.dart' as http;
import '../class/article.dart';

Future<List<Article>> initListArticle(List<Article> listeArticles) async {
  String baseUrl = 's3-4674.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/ld+json',
  };
  final uri = Uri.http(baseUrl, '/GDSport/public/api/articles');

  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    final List<dynamic> dataList = json.decode(response.body)['hydra:member'];
    for (var article in dataList) {
      final int articleId = article['id'];
      final int articlePrix = article['prix'];
      final String articleDesignation = article['designation'];
      final String articleDescription = article['description'];
      final String articleGenre = article['genre']['libelle'];
      final String articleType = article['type']['libelle'];
      final List<String> articleImages = [];
      for (var image in article['image']) {
        articleImages.add(image['name']);
      }
      final int articleNbFavoris = article['nbFavoris'];
      final String articleMarque = article['marque'];
      final num articleNote = article['note'];
      final bool articleTendance = article['tendance'];
      Article champion = Article(articleId, articlePrix, articleDesignation, articleDescription, articleGenre, articleType, articleImages, articleNbFavoris, articleMarque, articleNote, articleTendance);
      print(champion);
      listeArticles.add(champion);
    }
    print("Chargement terminé !");
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
  }
  return listeArticles;
}

Future<List<Article>> initListArticleTendance(List<Article> listeArticles) async {
  String baseUrl = 's3-4672.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/ld+json',
  };
  final uri = Uri.http(baseUrl, '/GDSport/public/api/articles', {'tendance': 'true'});

  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    final List<dynamic> dataList = json.decode(response.body)['hydra:member'];
    for (var article in dataList) {
      final int articleId = article['id'];
      final int articlePrix = article['prix'];
      final String articleDesignation = article['designation'];
      final String articleDescription = article['description'];
      final String articleGenre = article['genre']['libelle'];
      final String articleType = article['type']['libelle'];
      final List<String> articleImages = [];
      for (var image in article['image']) {
        articleImages.add(image['name']);
      }
      final int articleNbFavoris = article['nbFavoris'];
      final String articleMarque = article['marque'];
      final num articleNote = article['note'];
      final bool articleTendance = article['tendance'];
      Article champion = Article(articleId, articlePrix, articleDesignation, articleDescription, articleGenre, articleType, articleImages, articleNbFavoris, articleMarque, articleNote, articleTendance);
      print(champion);
      listeArticles.add(champion);
    }
    print("Chargement terminé !");
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
  }
  return listeArticles;
}