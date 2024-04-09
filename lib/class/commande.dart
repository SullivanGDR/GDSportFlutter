class Commande {
  final int id;
  final DateTime dateCommande;
  final DateTime dateLivraison;
  final String livraison;
  final double totalPrix;

  Commande(this.id, this.dateCommande, this.dateLivraison, this.livraison,
      this.totalPrix);

  int getId() {
    return id;
  }

  DateTime getDateCommande() {
    return dateCommande;
  }

  DateTime getDateLivraison() {
    return dateLivraison;
  }

  String getLivraison() {
    return livraison;
  }

  double getTotalPrix() {
    return totalPrix;
  }
}
