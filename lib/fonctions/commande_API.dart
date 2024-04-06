import 'dart:convert';
import 'package:gdsport_flutter/class/ajoutCommande.dart';
import 'package:gdsport_flutter/class/articleLight.dart';
import 'package:gdsport_flutter/class/commande.dart';
import 'package:gdsport_flutter/class/detailsCommande.dart';
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

Future<List<Commande>> getCommandesByIdUser(
    int userId, List<Commande> listeCommandes) async {
  String baseUrl = 's3-4674.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/ld+json',
  };
  final uri = Uri.http(
      baseUrl, '/GDSport/public/api/commandess', {'User.id': '$userId'});

  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    final List<dynamic> dataList = json.decode(response.body)['hydra:member'];
    for (var commande in dataList) {
      // Convertir les chaînes de caractères en objets DateTime
      DateTime dateCommande = DateTime.parse(commande["DateCommande"]);
      DateTime dateLivraison = DateTime.parse(commande["DateLivraison"]);

      // Créer une nouvelle instance de Commande en utilisant les objets DateTime
      Commande newCommande = Commande(
          commande["id"],
          dateCommande,
          dateLivraison,
          commande["livraison"],
          commande["totalPrix"].toDouble());

      listeCommandes.add(newCommande);
    }
    print("Chargement terminé !");
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
  }
  return listeCommandes;
}

Future<DetailsCommande?> getCommandeById(int commandeId) async {
  String baseUrl = 's3-4674.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/ld+json',
  };
  final uri = Uri.http(baseUrl, '/GDSport/public/api/commandess/$commandeId');

  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    final Map<String, dynamic> dataList = json.decode(response.body);

    List<AjoutCommande> ajoutCommandess = [];
    for (var ajoutCommande in dataList['ajoutCommandes']) {
      ArticleLight article = ArticleLight(
          ajoutCommande['Article']['id'],
          ajoutCommande['Article']['prix'],
          ajoutCommande['Article']['designation'],
          ajoutCommande['Article']['image']);
      AjoutCommande ajoutCommandeInfo = AjoutCommande(ajoutCommande['quantite'],
          ajoutCommande['prixUnit'], article, ajoutCommande['taille']);
      ajoutCommandess.add(ajoutCommandeInfo);
    }

    DateTime dateCommande = DateTime.parse(dataList["DateCommande"]);
    DateTime dateLivraison = DateTime.parse(dataList["DateLivraison"]);

    DetailsCommande commande = DetailsCommande(
        dataList['id'],
        dateCommande,
        dateLivraison,
        dataList['livraison'],
        dataList['totalPrix'],
        ajoutCommandess);

    print("Chargement terminé !");
    return commande;
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
  }
  return null;
}
