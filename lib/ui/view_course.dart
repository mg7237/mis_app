import 'package:flutter/material.dart';
import 'package:mis_app/models/student_model.dart';
import 'package:mis_app/models/students_score.dart';
import 'package:mis_app/util/firebase_utilities.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';
import 'package:mis_app/ui/view_student.dart';
import 'package:mis_app/models/course_model.dart';

class ViewCourse extends StatefulWidget {
  final String courseName;
  const ViewCourse({required this.courseName, key}) : super(key: key);

  @override
  _ViewCourseState createState() => _ViewCourseState();
}

class _ViewCourseState extends State<ViewCourse> {
  List<StudentScore> studentsScore = [];
  List<Student> students = [];
  List<Map<String, String>> studentData = [];
  Course? course;

  @override
  void initState() {
    super.initState();
    getCourseDetails();
  }

  Future getCourseDetails() async {
    students = [];
    studentData = [];
    if (widget.courseName == '') return;
    course = await FirebaseUtilities.getClassByCourseName(widget.courseName);
    students = await FirebaseUtilities.getStudentsByClass(widget.courseName);
    students.forEach((student) async {
      StudentScore studentScore = await FirebaseUtilities.getStudentsScore(
          widget.courseName, student.rollNumber);
      Map<String, String> studentGrade = {};
      studentGrade['name'] = student.lastName;
      studentGrade['grade'] = studentScore.grade;
      studentData.add(studentGrade);
    });
    print(studentData);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, theme, _) => MaterialApp(
            theme: theme.getTheme(),
            home: SafeArea(
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          (course?.instructorName == null)
                              ? ''
                              : course!.instructorName,
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Text('Course Code', style: TextStyle(fontSize: 15)),
                          SizedBox(width: 10),
                          Text(course?.code ?? '',
                              style: TextStyle(fontSize: 15))
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          Text('Course Name', style: TextStyle(fontSize: 15)),
                          SizedBox(width: 20),
                          Text(course?.name ?? '',
                              style: TextStyle(fontSize: 15)),
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          Text('Semester', style: TextStyle(fontSize: 15)),
                          SizedBox(width: 10),
                          Text(course?.currentSemester ?? '',
                              style: TextStyle(fontSize: 15))
                        ]),

                        SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          Text('No. of units:', style: TextStyle(fontSize: 15)),
                          SizedBox(width: 10),
                          Text(course?.unitsCount ?? '',
                              style: TextStyle(fontSize: 15))
                        ]),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Students',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(children: [
                            Container(
                                width: MediaQuery.of(context).size.width *
                                    50 /
                                    100,
                                child: Text('Name',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold))),
                            Container(
                                width: MediaQuery.of(context).size.width *
                                    20 /
                                    100,
                                child: Text('Grade',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)))
                          ]),
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return ListTile(
                                  title: Row(children: [
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        50 /
                                        100,
                                    child: Text(studentData[i]['name'] ?? '',
                                        style: TextStyle(fontSize: 14))),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        19 /
                                        100,
                                    child: Text(studentData[i]['grade'] ?? '',
                                        style: TextStyle(fontSize: 14))),
                                IconButton(
                                  icon: Icon(Icons.arrow_forward_ios_sharp),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewStudent(
                                                student: students[i])));
                                  },
                                )
                              ]));
                            },
                            separatorBuilder: (context, i) {
                              return Divider(
                                thickness: .5,
                                color: Colors.grey,
                                indent: 20,
                                endIndent: 20,
                              );
                            },
                            itemCount: studentData.length) //students.length)
                      ],
                    ),
                  )),
            )));
  }
}
