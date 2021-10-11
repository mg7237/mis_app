class Adviser {
  String? id;
  String firstName;
  String lastName;
  String middleName;
  String photoURL;
  List<String> classes;

  Adviser(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.middleName,
      required this.photoURL,
      required this.classes});
}
