class Course {
  String name;
  String code;
  String academicLevel;
  String faculty;
  String currentSemester;
  String instructorName;
  String unitsCount;
  Course(
      {required this.name,
      required this.code,
      required this.currentSemester,
      required this.instructorName,
      required this.unitsCount,
      required this.academicLevel,
      required this.faculty});

  Map<String, dynamic> toJson() {
    return {
      'code': this.code,
      'name': this.name,
      'current_semester': this.currentSemester,
      'instructor_name': this.instructorName,
      'units_count': this.unitsCount,
      'academic_level': this.academicLevel,
      'faculty': this.faculty
    };
  }

  static Course fromJson(Map<String, dynamic> json) {
    return Course(
        code: json['code'] ?? '',
        name: json['name'] ?? '',
        unitsCount: json['units_count'] ?? '',
        currentSemester: json['current_semester'] ?? '',
        academicLevel: json['academic_level'] ?? '',
        faculty: json['faculty'] ?? '',
        instructorName: json['instructor_name'] ?? '');
  }
}
