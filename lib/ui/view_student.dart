import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mis_app/models/course_model.dart';
import 'package:mis_app/util/firebase_utilities.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';
import 'package:mis_app/models/student_model.dart';
import 'package:mis_app/models/students_score.dart';
import 'package:mis_app/util/constants.dart';

class ViewStudent extends StatefulWidget {
  final Student student;
  const ViewStudent({required this.student});

  @override
  _ViewStudentState createState() => _ViewStudentState();
}

class _ViewStudentState extends State<ViewStudent> {
  late Student student;
  String _selectedSemester = 'Semester 1 2021-2022';
  Course? course;
  StudentScore? studentScore;
  int index = 0;

  @override
  void initState() {
    super.initState();
    student = widget.student;
    getStudentClassData();
  }

  Future getStudentClassData() async {
    course = await FirebaseUtilities.getClassByCourseName(student.program);
    if ((course ?? '') == '') return;

    studentScore = await FirebaseUtilities.getStudentsScore(
        student.program, student.rollNumber);
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
                        SizedBox(height: 20),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 70,
                                  width: 70,
                                  child: (student.photoUrl ?? '') == ''
                                      ? Image(
                                          image: AssetImage(
                                              'assets/icon/placeholder.jpg'),
                                        )
                                      : Image(
                                          image: NetworkImage(
                                              student.photoUrl ?? ''))),
                              SizedBox(width: 20),
                              Text(
                                FirebaseUtilities.fullName(
                                    firstName: student.firstName,
                                    lastName: student.lastName,
                                    middleName: student.middleName),
                                style: TextStyle(fontSize: 18),
                              )
                            ]),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text('Class Grades - ',
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                            DropdownButton(
                              value: _selectedSemester,
                              onChanged: (String? value) {
                                _selectedSemester = value ?? semesters[0];
                                setState(() {});
                              },
                              items: [
                                DropdownMenuItem(
                                    child: Text(
                                      semesters[0],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    value: semesters[0]),
                                DropdownMenuItem(
                                    child: Text(
                                      semesters[1],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    value: semesters[1]),
                                DropdownMenuItem(
                                    child: Text(
                                      semesters[2],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    value: semesters[2]),
                                DropdownMenuItem(
                                    child: Text(
                                      semesters[3],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    value: semesters[3]),
                                DropdownMenuItem(
                                    child: Text(
                                      semesters[4],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    value: semesters[4]),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Table(
                          children: [
                            TableRow(
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    border: Border.all(width: 1.5)),
                                children: [
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(width: 1.5))),
                                    child: Center(
                                      child: Text(
                                        'Class',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   height: 30,
                                  //   decoration: BoxDecoration(
                                  //       border: Border(
                                  //           right: BorderSide(width: 1.5))),
                                  //   child: Center(
                                  //     child: Text(
                                  //       'Description',
                                  //       style: TextStyle(
                                  //           fontSize: 8,
                                  //           fontWeight: FontWeight.bold),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Container(
                                  //   height: 30,
                                  //   decoration: BoxDecoration(
                                  //       border: Border(
                                  //           right: BorderSide(width: 1.5))),
                                  //   child: Center(
                                  //     child: Text(
                                  //       'Units',
                                  //       style: TextStyle(
                                  //           fontSize: 12,
                                  //           fontWeight: FontWeight.w600),
                                  //     ),
                                  //   ),
                                  // ),

                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(width: 1.5))),
                                    child: Center(
                                      child: Text(
                                        'Grading',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(width: 1.5))),
                                    child: Center(
                                      child: Text(
                                        'Grade',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(width: 1.5))),
                                    child: Center(
                                      child: Text(
                                        'Grade Points',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ]),
                            TableRow(
                                decoration: BoxDecoration(
                                    // color: Colors.grey[300],
                                    border: Border.all(width: 1.5)),
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              new AlertDialog(
                                                backgroundColor: Colors.blue,
                                                title:
                                                    new Text('Course Details'),
                                                content: Container(
                                                  height: 150,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('Course Name: ' +
                                                          course!.name),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text('Number of units: ' +
                                                          course!.unitsCount),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  new IconButton(
                                                      icon:
                                                          new Icon(Icons.close),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      })
                                                ],
                                              ));
                                    },
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(width: 1.5))),
                                      child: Center(
                                        child: Text(
                                          course!.code,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.blue[800],
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(width: 1.5))),
                                    child: Center(
                                      child: Text(
                                        studentScore!.grade,
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(width: 1.5))),
                                    child: Center(
                                      child: Text(
                                        studentScore!.grading,
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(width: 1.5))),
                                    child: Center(
                                      child: Text(
                                        studentScore!.gradePoints,
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ],
                        )
                      ],
                    ),
                  )),
            )));
  }
}
