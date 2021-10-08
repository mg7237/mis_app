import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';
import 'package:mis_app/ui/view_student.dart';

class ViewCourse extends StatefulWidget {
  const ViewCourse({Key? key}) : super(key: key);

  @override
  _ViewCourseState createState() => _ViewCourseState();
}

class _ViewCourseState extends State<ViewCourse> {
  List<Map<String, String>> courses = [
    {
      'name': 'Kasaysayan 1',
      'code': 'KAS 1',
      'current_semester': '2021-2022',
      'instructor_name': 'Doe, Jane B.',
      'units_count': '3'
    },
    {
      'name': 'Physical Fitness 1',
      'code': 'PE 1',
      'semester': '2021-2022',
      'instructor': 'Doe, John V.',
      'units_count': '5'
    },
  ];

  List<Map<String, dynamic>> students = [
    {
      'name': 'Moreno, Jerome A.',
      'photo': 'google.com',
      'roll_number': 214823,
      'education_level': 'Undergraduate',
      'classes': [
        {
          'code': 'KAS 1',
          'grade': '8.5',
          'grade_points': '8.345',
          'semester': '2021-2022',
        },
        {
          'code': 'PE 1',
          'grade': '4.5',
          'grade_points': '4.345',
          'semester': '2021-2022',
        }
      ],
    },
    {
      'name': 'Jon, Doe B.',
      'photo': 'google.com',
      'roll_number': 214823,
      'education_level': 'Undergraduate',
      'classes': [
        {
          'code': 'KAS 1',
          'grade': '8.5',
          'grade_points': '8.345',
          'semester': '2021-2022',
        },
        {
          'code': 'PE 1',
          'grade': '4.5',
          'grade_points': '4.345',
          'semester': '2021-2022',
        }
      ],
    }
  ];
  int expandedIndex = -1;
// ['KAS 1', 'WIKA 1', 'ETHICS 1', 'PE 1', 'See all students']

  _showListOfStudents(int i) {
    if (expandedIndex == i) {
      expandedIndex = -1;
    } else {
      expandedIndex = i;
    }
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
                        SizedBox(height: 20),
                        Text(
                          'Doe Jane B.',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(courses[0]['code'] ?? '',
                            style: TextStyle(fontSize: 15)),
                        Row(children: [
                          Text('Semester', style: TextStyle(fontSize: 15)),
                          SizedBox(width: 20),
                          Text(courses[0]['semester'] ?? '',
                              style: TextStyle(fontSize: 15))
                        ]),
                        Row(children: [
                          Text('Instructor', style: TextStyle(fontSize: 15)),
                          SizedBox(width: 20),
                          Text(courses[0]['instructor'] ?? '',
                              style: TextStyle(fontSize: 15)),
                        ]),
                        Row(children: [
                          Text('No. of units:', style: TextStyle(fontSize: 15)),
                          SizedBox(width: 20),
                          Text(courses[0]['units_count'] ?? '',
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
                                    child: Text(students[i]['name'],
                                        style: TextStyle(fontSize: 14))),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        19 /
                                        100,
                                    child: Text('5.5',
                                        style: TextStyle(fontSize: 14))),
                                IconButton(
                                  icon: Icon(Icons.arrow_forward_ios_sharp),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewStudent()));
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
                            itemCount: students.length)
                      ],
                    ),
                  )),
            )));
  }
}
