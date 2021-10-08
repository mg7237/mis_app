class Student {
  String? id;
  String firstName;
  String lastName;
  String middleName;
  String eductationLevel;
  String rollNumber;
  String currentSemester;
  Student(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.middleName,
      required this.eductationLevel,
      required this.rollNumber,
      required this.currentSemester});
}
