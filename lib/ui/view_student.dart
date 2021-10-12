import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';
import 'package:mis_app/models/student_model.dart';

class ViewStudent extends StatefulWidget {
  const ViewStudent({Key? key}) : super(key: key);

  @override
  _ViewStudentState createState() => _ViewStudentState();
}

class _ViewStudentState extends State<ViewStudent> {
  late Student student;
  String _selectedSemester = 'Semester 1 2021-2022';
  List<String> semesters = [
    'Semester 1 2021-2022',
    'Semester 2 2020-2021',
    'Semester 1 2020-2021',
    'Semester 2 2019-20',
    'Semester 1 2019-2020',
  ];
  int index = 0;

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
                                  child: Image(
                                    image: AssetImage(
                                        'assets/icon/placeholder.jpg'),
                                  )),
                              SizedBox(width: 20),
                              Text(
                                'Moreno, Jerome A.',
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
                                                      Text(
                                                          'Course Name: Kasasysayan 1'),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                          'Number of units: 5'),
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
                                          'KAS 1',
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
                                        'A+',
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
                                        '8.9',
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
                                        '8.94',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
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
                                    onTap: () async {
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
                                                      Text(
                                                          'Course Name: Physical Education'),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                          'Number of units: 1'),
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
                                          'PE 1',
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
                                        'B++',
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
                                        '7.645',
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
                                        '8.94',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ])
                          ],
                        )
                      ],
                    ),
                  )),
            )));
  }
}
