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

  static Course fromJson(Map<String, dynamic> json) {
    return Course(
        id: 'id',
        code: json['code'] ?? '',
        name: json['name'] ?? '',
        unitsCount: json['units_count'] ?? '',
        currentSemester: json['current_semester'],
        instructorName: json['instructor_name']);
  }
}
