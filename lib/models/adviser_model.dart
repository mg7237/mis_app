class Adviser {
  String? id;
  String firstName;
  String lastName;
  String middleName;
  String? photoURL;
  List<String>? classes;

  Adviser(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.middleName,
      this.photoURL,
      this.classes});

  Map<String, dynamic> toJson() {
    return {
      'first_name': this.firstName,
      'last_name': this.lastName,
      'middle_name': this.middleName,
      'id': this.id,
      'photo_url': this.photoURL,
      'classes': this.classes
    };
  }

  static Adviser fromMap(Map<String, dynamic> adviserData) {
    List<String> classList = [];
    if (adviserData['classes'] != null) {
      if (classList is List) {
        classList.forEach((value) {
          classList.add(value.toString());
        });
      }
    }
    return Adviser(
        id: adviserData['id'],
        firstName: adviserData['first_name'] ?? '',
        middleName: adviserData['middle_name'] ?? '',
        lastName: adviserData['last_name'] ?? '',
        photoURL: adviserData['photo_url'] ?? '',
        classes: classList);
  }
}
