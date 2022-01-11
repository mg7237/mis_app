class StudentScore {
  String rollNumber;
  String courseName;
  String grading;
  String grade;
  String gradePoints;

  StudentScore({
    required this.rollNumber,
    required this.courseName,
    required this.grading,
    required this.grade,
    required this.gradePoints,
  });

  Map<String, dynamic> toJson() {
    return {
      'roll_number': this.rollNumber,
      'course_name': this.courseName,
      'grading': this.grading,
      'grade': this.grade,
      'grade_points': this.gradePoints,
    };
  }

  static StudentScore fromJson(Map<String, dynamic> json) {
    return StudentScore(
      rollNumber: json['roll_number'],
      courseName: json['course_name'] ?? '',
      grading: json['grading'] ?? '',
      grade: json['grade'] ?? '',
      gradePoints: json['grade_points'] ?? '',
    );
  }
}
