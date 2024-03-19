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

Future<bool> delFavori(String token, int id, int idFav) async {
  String baseUrl = 's3-4672.nuage-peda.fr';
  Map<String, String> headers = {
    "Content-type": "application/ld+json",
    "Accept": 'application/ld+json',
    "Authorization": "Bearer $token"
  };

  final uri = Uri.http(baseUrl,
      '/GDSport/public/api/users/$id/remove_favori/$idFav'); // Utilisation de Uri.https pour une connexion sécurisée

  try {
    final response = await http.post(uri, headers: headers,body: jsonEncode({}),);

    if (response.statusCode == 201) {
      print("delete ok");
      return true;
    } else {
      print("Error: ${response.statusCode} - ${response.reasonPhrase}");
      return false;
    }
  } catch (e) {
    print("Exception during delete: $e");
    return false;
  }
}

Future<bool> addFavori(String token, int id, int idFav) async {
  String baseUrl = 's3-4672.nuage-peda.fr';
  Map<String, String> headers = {
    "Content-type": "application/ld+json",
    "Accept": 'application/ld+json',
    "Authorization": "Bearer $token"
  };

  final uri = Uri.http(baseUrl,
      '/GDSport/public/api/users/$id/add_favori/$idFav'); // Utilisation de Uri.https pour une connexion sécurisée

  try {
    final response = await http.post(uri, headers: headers,body: jsonEncode({}),);

    if (response.statusCode == 201) {
      print("delete ok");
      return true;
    } else {
      print("Error: ${response.statusCode} - ${response.reasonPhrase}");
      return false;
    }
  } catch (e) {
    print("Exception during delete: $e");
    return false;
  }
}
