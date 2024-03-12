import 'dart:convert';
import 'package:http/http.dart' as http;
import '../class/user.dart';
import '../class/ajoutPanier.dart';
import '../class/articleLight.dart';

Future<List<AjoutPanier>> getPanier(token, id, List<AjoutPanier> panier) async {
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
