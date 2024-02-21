class User {
  final int id;
  final String token;
  final String email;
  final String prenom;
  final String nom;
  final String? adresse;
  final String? ville;
  final String? codePostal;

  User(this.id,this.email, this.token, this.prenom, this.nom,this.adresse,this.ville,this.codePostal );

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
    return nom;
  }

  String? getAdresse() {
    return adresse;
  }
  String? getVille() {
    return ville;
  }
  String? getCodePostal() {
    return codePostal;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'],
      json['email'],
      json['token'],
      json['prenom'],
      json['nom'],
      json['adresse'],
      json['ville'],
      json['codePostal']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'token': token,
      'email': email,
      'prenom':prenom,
      'name': nom,
      'adresse':ville,
      'ville':ville,
      'codePostal':codePostal
    };
  }
}
