import 'dart:convert';
import 'package:http/http.dart' as http;
import '../class/article.dart'; // Assurez-vous que le chemin d'accès est correct

Future<Article> getArticleById(int id) async {
   String baseUrl = 's3-4674.nuage-peda.fr';
  final Uri uri = Uri.http(baseUrl, '/GDSport/public/api/articles/$id');

  final http.Response response = await http.get(
    uri,
    headers: {
      "Content-type": "application/json; charset=UTF-8",
      "Accept": 'application/ld+json',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    final int articleId = data['id'];
    final int articlePrix = data['prix'];
    final String articleDesignation = data['designation'];
    final String articleDescription = data['description'];
    final String articleGenre = data['genre']['libelle'];
    final String articleType = data['type']['libelle'];
    final List<String> articleImages = (data['image'] as List).map((image) => image['name'].toString()).toList();
    final int articleNbFavoris = data['nbFavoris'];
    final String articleMarque = data['marque'];
    final num articleNote = data['note'];
    final bool articleTendance = data['tendance'];

    return Article(
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
  } else {
    throw Exception('Failed to load article');
  }
}
