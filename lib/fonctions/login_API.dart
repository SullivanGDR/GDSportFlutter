import 'dart:convert';
import 'package:http/http.dart' as http;
import '../class/user.dart';

Future<User?> login(email,mdp) async {
  String baseUrl = 's3-4672.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/json",
    "Accept": 'application/json',
  };
  final uri = Uri.http(baseUrl, '/GDSport/public/api/authentication_token');

  final response = await http.post(
    uri,
    headers: header,
    body: jsonEncode({
      "email": email,
      "password": mdp
    }),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    print(data["token"]);
    var  user = User(data["data"]["id"], data["token"], data["data"]["prenom"], data["data"]["nom"], [], []);
    return user;
  }else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
    return null;
  }
}
