import 'dart:convert';
import 'package:gdsport_flutter/class/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

Future<void> resetDataUserLocal(token, id) async {
  String baseUrl = 's3-4672.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/ld+json',
    'Authorization': "Bearer $token"
  };
  final uri = Uri.http(baseUrl, '/GDSport/public/api/users/$id');

  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    var value = await storage.read(key: "userData");
    if (value != null) {
      var token = User.fromJson(jsonDecode(value)).getToken();
      final Map<String, dynamic> data = json.decode(response.body);
      int nbfav = 0;
      if (data["nbFav"] != null) {
        nbfav = data["nbFav"];
      }
      User user = User(
          data["id"],
          nbfav,
          data["email"],
          token,
          data["prenom"],
          data["nom"],
          data["adresse"],
          data["ville"],
          data["codePostal"],
          data["pays"]);
      await storage.write(key: "userData", value: jsonEncode(user.toJson()));
      print("mise à jour des données effectuer");
    }
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
  }
}

Future<bool> modifProfil(String token, int id, String nom, String prenom,
    String email, String adresse, String ville, String pays, String cp) async {
  String baseUrl = 's3-4672.nuage-peda.fr';
  Map<String, String> headers = {
    "Content-type": "application/merge-patch+json",
    "Accept": 'application/ld+json',
    "Authorization": "Bearer $token"
  };

  final uri = Uri.http(baseUrl, '/GDSport/public/api/users/$id');

  try {
    final response = await http.patch(
      uri,
      headers: headers,
      body: jsonEncode({
        "email": email,
        "nom": nom,
        "prenom": prenom,
        "adresse": adresse,
        "pays": pays,
        "ville": ville,
        "codePostal": cp
      }),
    );

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
