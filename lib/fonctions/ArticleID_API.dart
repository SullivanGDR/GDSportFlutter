import 'dart:convert';
import 'package:http/http.dart' as http;
import '../class/article.dart';

Future<Article> getArticleById(int id) async {
  String baseUrl = 's3-4674.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/ld+json',
  };

  final uri = Uri.http(baseUrl, '/GDSport/public/api/articles/$id');

  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    final dynamic data = json.decode(response.body);

    final int articleId = data['id'];
    final int articlePrix = data['prix'];
    final String articleDesignation = data['designation'];
    final String articleDescription = data['description'];
    final String articleGenre = data['genre']['libelle'];
    final String articleType = data['type']['libelle'];
    final List<String> articleImages = [];
    for (var image in data['image']) {
      articleImages.add(image['name']);
    }
    final int articleNbFavoris = data['nbFavoris'];
    final String articleMarque = data['marque'];
    final num articleNote = data['note'];
    final bool articleTendance = data['tendance'];

    Article article = Article(
      articleId,
      articlePrix,
      articleDesignation,
      articleDescription,
      articleGenre,
      articleType,
      articleImages,
      articleNbFavoris,
      articleMarque,
      articleNote,
      articleTendance,
    );

    return article;
  } else {
    throw Exception('Failed to load article');
  }
}
