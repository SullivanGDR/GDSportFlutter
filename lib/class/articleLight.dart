class ArticleLight {
  final int _id;
  final int _prix;
  final String _designation;
  final List<dynamic> _images;

  ArticleLight(
    this._id,
    this._prix,
    this._designation,
    this._images,
  );

  int getId() {
    return _id;
  }

  int getPrix() {
    return _prix;
  }

  String getDesignation() {
    return _designation;
  }

  List getImages() {
    return _images;
  }
}
