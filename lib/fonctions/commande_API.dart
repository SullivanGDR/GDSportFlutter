import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<int> createCommande(String user, DateTime dateCommande, String livraison,
    DateTime dateLivraison, double totalPrix) async {
  String baseUrl = 's3-4674.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/ld+json",
    "Accept": 'application/ld+json',
  };
  final uri = Uri.http(baseUrl, '/GDSport/public/api/commandess');

  try {
    Map<String, dynamic> jsonData = {
      "livraison": livraison,
      "totalPrix": totalPrix,
      "user": '/GDSport/public/api/users/$user',
      "dateCommande": DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateCommande),
      "dateLivraison": DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateLivraison),
    };

    final response = await http.post(
      uri,
      headers: header,
      body: jsonEncode(jsonData),
    );

    if (response.statusCode == 201) {
      Map<String, dynamic> responseJson = jsonDecode(response.body);
      print("Stock créé avec succès!");
      return responseJson['id'];
    } else {
      print(
          "Erreur lors de la création du bien: ${response.statusCode} - ${response.reasonPhrase}");
      return 0;
    }
  } catch (error) {
    print("Erreur lors de la création du bien: $error");
    return 0;
  }
}

Future<void> createAjoutCommande(String commande, String article, int quantite,
    int prixUnit, String taille) async {
  String baseUrl = 's3-4674.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/ld+json",
    "Accept": 'application/ld+json',
  };
  final uri = Uri.http(baseUrl, '/GDSport/public/api/ajout_commandes');

  try {
    Map<String, dynamic> jsonData = {
      "quantite": quantite,
      "prixUnit": prixUnit,
      "commande": '/GDSport/public/api/commandess/$commande',
      "article": '/GDSport/public/api/articles/$article',
      "taille": taille
    };

    final response = await http.post(
      uri,
      headers: header,
      body: jsonEncode(jsonData),
    );

    if (response.statusCode == 201) {
      print("Stock créé avec succès!");
    } else {
      print(
          "Erreur lors de la création du bien: ${response.statusCode} - ${response.reasonPhrase}");
    }
  } catch (error) {
    print("Erreur lors de la création du bien: $error");
  }
}
