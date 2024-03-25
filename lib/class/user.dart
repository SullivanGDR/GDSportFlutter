class User {
  final int _id;
  final int _nbFav;
  final String _token;
  final String _email;
  final String _prenom;
  final String _nom;
  final String? _adresse;
  final String? _ville;
  final String? _codePostal;
  final String? _pays;

  User(this._id, this._nbFav, this._email, this._token, this._prenom, this._nom,
      this._adresse, this._ville, this._codePostal, this._pays);

  int getId() {
    return _id;
  }

  int getNbFav() {
    return _nbFav;
  }

  String getToken() {
    return _token;
  }

  String getEmail() {
    return _email;
  }

  String getPrenom() {
    return _prenom;
  }

  String getNom() {
    return _nom;
  }

  String? getAdresse() {
    return _adresse;
  }

  String? getVille() {
    return _ville;
  }

  String? getCodePostal() {
    return _codePostal;
  }

  String? getPays() {
    return _pays;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        json['id'],
        json['nbFav'],
        json['email'],
        json['token'],
        json['prenom'],
        json['name'],
        json['adresse'],
        json['ville'],
        json['codePostal'],
        json['pays']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'nbFav': _nbFav,
      'token': _token,
      'email': _email,
      'prenom': _prenom,
      'name': _nom,
      'adresse': _ville,
      'ville': _ville,
      'codePostal': _codePostal,
      'pays': _pays
    };
  }
}
