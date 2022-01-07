import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mis_app/models/course_model.dart';
import 'package:mis_app/ui/view_course.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';
import 'package:mis_app/models/student_model.dart';
import 'package:mis_app/util/constants.dart';
import 'package:mis_app/util/firebase_utilities.dart';

class ViewCourseList extends StatefulWidget {
  const ViewCourseList({Key? key}) : super(key: key);

  @override
  _ViewCourseListState createState() => _ViewCourseListState();
}

class _ViewCourseListState extends State<ViewCourseList> {
  late Student student;
  List<TableRow> tableRows = [];
  String _selectedSemester = 'Semester 1 2021-2022';
  List<Course> courses = [];
  int index = 0;

  @override
  void initState() {
    super.initState();
    getCourseList();
  }

  Future getCourseList() async {
    courses =
        await FirebaseUtilities.getCourseListBySemester(_selectedSemester);
    tableRows = [
      TableRow(
          decoration: BoxDecoration(
              color: Colors.grey[300], border: Border.all(width: 1.5)),
          children: [
            Container(
              height: 40,
              decoration:
                  BoxDecoration(border: Border(right: BorderSide(width: 1.5))),
              child: Center(
                child: Text(
                  'Course Code',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(
              height: 40,
              decoration:
                  BoxDecoration(border: Border(right: BorderSide(width: 1.5))),
              child: Center(
                child: Text(
                  'Course Name',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(
              height: 40,
              decoration:
                  BoxDecoration(border: Border(right: BorderSide(width: 1.5))),
              child: Center(
                child: Text(
                  'No. Of Units',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(
              height: 40,
              decoration:
                  BoxDecoration(border: Border(right: BorderSide(width: 1.5))),
              child: Center(
                child: Text(
                  'Adviser',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(
              width: 30,
              height: 40,
              decoration:
                  BoxDecoration(border: Border(right: BorderSide(width: 1.5))),
              child: Center(),
            ),
          ])
    ];

    if (courses.isNotEmpty) {
      courses.forEach((element) {
        tableRows.add(TableRow(
            decoration: BoxDecoration(border: Border.all(width: 1.5)),
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.5))),
                child: Center(
                  child: Text(
                    element.code,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.5))),
                child: Center(
                  child: Text(
                    element.name,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.5))),
                child: Center(
                  child: Text(
                    element.unitsCount,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.5))),
                child: Center(
                  child: Text(
                    element.instructorName,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.5))),
                child: Center(
                    child: IconButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ViewCourse())),
                        icon: Icon(Icons.arrow_forward_ios_sharp))),
              ),
            ]));
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 40);
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
                        Text('Courses',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text('Courses - ',
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                            DropdownButton(
                              value: _selectedSemester,
                              onChanged: (String? value) async {
                                _selectedSemester = value ?? semesters[0];
                                await getCourseList();
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
                          columnWidths: {
                            0: FixedColumnWidth(width * 15 / 100),
                            1: FixedColumnWidth(width * 30 / 100),
                            2: FixedColumnWidth(width * 15 / 100),
                            3: FixedColumnWidth(width * 30 / 100),
                            4: FixedColumnWidth(width * 10 / 100),
                          },
                          children: tableRows,
                        )
                      ],
                    ),
                  )),
            )));
  }
}
