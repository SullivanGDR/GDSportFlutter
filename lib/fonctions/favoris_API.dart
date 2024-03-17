import 'dart:convert';
import 'package:http/http.dart' as http;
import '../class/articleLight.dart';

Future<List<ArticleLight>> getFavoris(
    token, id, List<ArticleLight> listFavoris) async {
  String baseUrl = 's3-4672.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/ld+json',
    'Authorization': "Bearer $token"
  };
  final uri = Uri.http(baseUrl, '/GDSport/public/api/users/$id');

  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    var favoris = data["Favoris"];
    for (var favori in favoris) {
      listFavoris.add(ArticleLight(
          favori["id"], 0, favori["designation"], favori["image"]));
    }
    return listFavoris;
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
    return [];
  }
}

Future<void> delFavori(String token, int id, int idFav) async {
  String baseUrl = 's3-4672.nuage-peda.fr';
  Map<String, String> headers = {
    "Authorization": "Bearer $token"
  }; // Suppression de l'entrée vide dans les en-têtes

  final uri = Uri.http(baseUrl,
      '/GDSport/public/api/users/$id/favoris/$idFav'); // Utilisation de Uri.https pour une connexion sécurisée

  try {
    final response = await http.delete(uri, headers: headers);

    if (response.statusCode == 204) {
      print("delete ok");
    } else {
      print("Error: ${response.statusCode} - ${response.reasonPhrase}");
    }
  } catch (e) {
    print("Exception during delete: $e");
  }
}
