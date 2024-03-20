import 'articleLight.dart';

class AjoutPanier {
  final int _id;
  final ArticleLight _article;
  final int _qte;
  final String _taille;

  AjoutPanier(
    this._id,
    this._article,
    this._qte,
    this._taille,
  );

  int getId() {
    return _id;
  }

  ArticleLight getArticle() {
    return _article;
  }

  int getQte() {
    return _qte;
  }

  String getTaille() {
    return _taille;
  }
}
