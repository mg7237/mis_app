class Student {
  String? id;
  String firstName;
  String lastName;
  String middleName;
  String academicLevel;
  String faculty;
  String program;
  String? photoUrl;
  String adviser;
  String rollNumber;
  String dateOfBirth;
  String currentSemester;
  Student({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.dateOfBirth,
    required this.academicLevel,
    required this.faculty,
    required this.program,
    required this.adviser,
    required this.rollNumber,
    required this.currentSemester,
    this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'photo_url': this.photoUrl,
      'first_name': this.firstName,
      'middle_name': this.middleName,
      'last_name': this.lastName,
      'academicLevel': this.academicLevel,
      'faculty': this.faculty,
      'program': this.program,
      'adviser': this.adviser,
      'roll_number': this.rollNumber,
      'date_of_birth': this.dateOfBirth.toString(),
      'current_semester': this.currentSemester
    };
  }
}
