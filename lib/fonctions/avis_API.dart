import 'dart:convert';
import 'package:http/http.dart' as http;
import '../class/avis.dart'; // Vérifiez que le chemin d'accès est correct

Future<List<Avis>> getAvisByArticleId(int articleId) async {
  final String baseUrl = 's3-4674.nuage-peda.fr';
  final Uri uri = Uri.http(baseUrl, '/GDSport/public/api/articles/$articleId');

  final http.Response response = await http.get(uri, headers: {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/ld+json',
  });

  if (response.statusCode == 200) {
    final List<dynamic> avisData = json.decode(response.body); // Assurez-vous que ce chemin est correct.
    return avisData.map((data) => Avis(
      data['id'],
      DateTime.parse(data['date']),
      data['message'],
      data['user'],
      data['note'],
    )).toList();
  } else {
    throw Exception('impossible de charger les avis');
  }
}
