class Student {
  String? uid;
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
    this.uid,
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
      'uid': this.uid,
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

  static Student fromJson(Map<String, dynamic> json) {
    return Student(
      uid: json['uid'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      middleName: json['middle_name'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      academicLevel: json['academic_level'] ?? '',
      faculty: json['faculty'] ?? '',
      program: json['program'] ?? '',
      adviser: json['adviser'] ?? '',
      rollNumber: json['roll_number'] ?? '',
      currentSemester: json['current_semester'] ?? '',
      photoUrl: json['photo_url'] ?? '',
    );
  }
}
