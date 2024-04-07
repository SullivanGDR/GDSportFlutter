import 'package:gdsport_flutter/class/articleLight.dart';

class AjoutCommande {
  final int quantite;
  final int prixUnit;
  final ArticleLight article;
  final String taille;

  AjoutCommande(this.quantite, this.prixUnit, this.article, this.taille);
}
