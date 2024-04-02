import 'ajoutCommande.dart';

class DetailsCommande {
  final int id;
  final DateTime dateCommande;
  final DateTime dateLivraison;
  final String livraison;
  final double totalPrix;
  final List<AjoutCommande> ajoutCommande;

  DetailsCommande(this.id, this.dateCommande, this.dateLivraison,
      this.livraison, this.totalPrix, this.ajoutCommande);
}
