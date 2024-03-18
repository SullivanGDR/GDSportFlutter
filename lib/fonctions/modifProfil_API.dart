import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> modifProfil(String token, int id,String nom ,String prenom,String email,String adresse,String ville,String pays,String cp) async {
  String baseUrl = 's3-4672.nuage-peda.fr';
  Map<String, String> headers = {
    "Content-type": "application/merge-patch+json",
    "Accept": 'application/ld+json',
    "Authorization": "Bearer $token"
  };

  final uri = Uri.http(baseUrl,
      '/GDSport/public/api/users/$id');

  try {
    final response = await http.patch(uri, headers: headers,body: jsonEncode({
      "email": email,
      "nom": nom,
      "prenom": prenom,
      "adresse": adresse,
      "pays": pays,
      "ville": ville,
      "codePostal": cp
    }),);

    if (response.statusCode == 200) {
      print("modif ok");
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
