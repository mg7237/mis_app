class Course {
  String? id;
  String name;
  String code;
  String currentSemester;
  String instructorName;
  String unitsCount;
  Course(
      {this.id,
      required this.name,
      required this.code,
      required this.currentSemester,
      required this.instructorName,
      required this.unitsCount});
}
