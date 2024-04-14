class Avis {
  final String id;
  final DateTime date;
  final String message;
  final String user;
  final int note;

  Avis(this.id, this.date, this.message, this.user, this.note);

  String getId() {
    return id;
  }

  DateTime getDate() {
    return date;
  }

  String getMessage() {
    return message;
  }

  String getUser() {
    return user;
  }

  int getNote() {
    return note;
  }

}
