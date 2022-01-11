import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';
import 'package:mis_app/ui/view_student.dart';
import 'package:mis_app/models/student_model.dart';
import 'package:mis_app/util/firebase_utilities.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  List<Student> students = [];

  @override
  void initState() {
    super.initState();
    getStudents();
  }

  Future getStudents() async {
    students = await FirebaseUtilities.getStudentList();
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
                        Text('Students',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(students[i].firstName,
                                        style: TextStyle(fontSize: 16)),
                                    IconButton(
                                        icon:
                                            Icon(Icons.arrow_forward_ios_sharp),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewStudent(
                                                          student:
                                                              students[i])));
                                        }),
                                  ],
                                ),
                              );
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
