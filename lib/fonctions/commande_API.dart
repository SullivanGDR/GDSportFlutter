import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> createCommande(String user, DateTime dateCommande,
    String livraison, DateTime dateLivraison, double totalPrix) async {
  String baseUrl = 's3-4674.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/ld+json",
    "Accept": 'application/ld+json',
  };
  final uri = Uri.http(baseUrl, '/GestionStockNeuville/public/api/commandess');

  try {
    Map<String, dynamic> jsonData = {
      "User": '/GDSport/public/api/types_bienss/$user',
      "DateCommande": dateCommande,
      "livraison": livraison,
      "DateLivraison": dateLivraison,
      "totalPrix": totalPrix
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
      return ("Erreur lors de la création du bien: ${response.statusCode} - ${response.reasonPhrase}");
    }
  } catch (error) {
    return ("Erreur lors de la création du bien: $error");
  }
}

Future<void> createAjoutCommande(String commande, String article, int quantite,
    int prixUnit, String taille) async {
  String baseUrl = 's3-4674.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/ld+json",
    "Accept": 'application/ld+json',
  };
  final uri =
      Uri.http(baseUrl, '/GestionStockNeuville/public/api/ajout_commandes');

  try {
    Map<String, dynamic> jsonData = {
      "quantite": quantite,
      "prixUnit": prixUnit,
      "Commande": '/GDSport/public/api/commandess/$commande',
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
