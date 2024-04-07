import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> register(email, mdp, nom, prenom, adresse, ville, cp, pays) async {
  String baseUrl = 's3-4674.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/ld+json",
    "Accept": 'application/ld+json',
  };
  final uri = Uri.http(baseUrl, '/GDSport/public/api/users');

  final response = await http.post(
    uri,
    headers: header,
    body: jsonEncode({
      "email": email,
      "password": mdp,
      "nom": nom,
      "prenom": prenom,
      "adresse": adresse,
      "pays": pays,
      "ville": ville,
      "codePostal": cp
    }),
  );

  if (response.statusCode == 201) {
    print("compte créé");
    return true;
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
    return false;
  }
}
