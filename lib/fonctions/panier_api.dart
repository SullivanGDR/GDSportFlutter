import 'dart:convert';
import 'package:http/http.dart' as http;
import '../class/ajoutPanier.dart';
import '../class/articleLight.dart';

Future<List<AjoutPanier>> getPanier(token, id, List<AjoutPanier> panier) async {
  String baseUrl = 's3-4674.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/ld+json',
    'Authorization': "Bearer $token"
  };
  final uri = Uri.http(baseUrl, '/GDSport/public/api/users/$id');

  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    var ajouters = data["panier"]["ajouters"];
    for (var ajout in ajouters) {
      var produit = ajout["produit"];
      panier.add(AjoutPanier(
          ajout["id"],
          ArticleLight(produit["id"], produit["prix"], produit["designation"],
              produit["image"]),
          ajout["quantite"],
          ajout["taille"]));
    }
    return panier;
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
    return [];
  }
}

Future<void> addQte(token, id, qte) async {
  String baseUrl = 's3-4674.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/merge-patch+json",
    "Accept": 'application/ld+json',
    'Authorization': "Bearer $token"
  };
  final uri = Uri.http(baseUrl, '/GDSport/public/api/ajouters/$id');

  final response = await http.patch(
    uri,
    headers: header,
    body: jsonEncode({"quantite": qte + 1}),
  );

  if (response.statusCode == 200) {
    print("modification ok");
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
  }
}

Future<void> supQte(token, id, qte) async {
  String baseUrl = 's3-4674.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/merge-patch+json",
    "Accept": 'application/ld+json',
    'Authorization': "Bearer $token"
  };
  final uri = Uri.http(baseUrl, '/GDSport/public/api/ajouters/$id');

  final response = await http.patch(
    uri,
    headers: header,
    body: jsonEncode({"quantite": qte - 1}),
  );

  if (response.statusCode == 200) {
    print("modification ok");
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
  }
}

Future<void> delArticle(String token, int id) async {
  String baseUrl = 's3-4674.nuage-peda.fr';
  Map<String, String> headers = {
    "Authorization": "Bearer $token"
  }; // Suppression de l'entrée vide dans les en-têtes

  final uri = Uri.http(baseUrl,
      '/GDSport/public/api/ajouters/$id'); // Utilisation de Uri.https pour une connexion sécurisée

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
