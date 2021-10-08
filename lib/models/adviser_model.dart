class Advisor {
  String? id;
  String firstName;
  String lastName;
  String middleName;
  String photoURL;
  List<String> classes;

  Advisor(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.middleName,
      required this.photoURL,
      required this.classes});
}
