class Course {
  String? id;
  String name;
  String code;
  String? currentSemester;
  String? instructorName;
  String unitsCount;
  Course(
      {this.id,
      required this.name,
      required this.code,
      this.currentSemester,
      this.instructorName,
      required this.unitsCount});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'code': this.code,
      'name': this.name,
      'current_semester': this.currentSemester,
      'instructor_name': this.instructorName,
      'units_count': this.unitsCount
    };
  }
}
