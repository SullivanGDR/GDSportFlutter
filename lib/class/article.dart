class Article {
  final int id;
  final int prix;
  final String designation;
  final String description;
  final String genre;
  final String type;
  final List<String> images;
  final int nbFavoris;
  final String marque;
  final num note;
  final bool tendance;

  Article(this.id, this.prix, this.designation, this.description, this.genre, this.type, this.images, this.nbFavoris, this.marque, this.note, this.tendance);

  int getId() {
    return id;
  }
  int getPrix() {
    return prix;
  }
  String getDesignation(){
    return designation;
  }
  String getDescription() {
    return description;
  }
  String getGenre() {
    return genre;
  }
  String getType() {
    return type;
  }
  List getImages() {
    return images;
  }
  int getNbFavoris() {
    return nbFavoris;
  }
  String getMarque(){
    return marque;
  }
  num getNote() {
    return note;
  }
  bool getTendance() {
    return tendance;
  }
}