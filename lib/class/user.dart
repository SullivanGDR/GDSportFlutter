import 'article.dart';

class User {
  final int id;
  final String token;
  final String prenom;
  final String nom;
  final List<Article> favoris;
  final List<Article> panier;

  User(this.id, this.token, this.prenom, this.nom, this.favoris, this.panier);

  int getId() {
    return id;
  }

  String getToken() {
    return token;
  }

  String getPrenom() {
    return prenom;
  }

  String getNom() {
    return token;
  }

  List<Article> getFavoris() {
    return favoris;
  }

  List<Article> getPanier() {
    return panier;
  }
}
