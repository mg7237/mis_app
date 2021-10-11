import 'package:flutter/material.dart';
import 'package:mis_app/providers/theme_manager.dart';

import 'package:flutter/cupertino.dart';
import 'package:mis_app/ui/admin_menu.dart';

import 'package:mis_app/ui/add_adviser.dart';
import 'package:mis_app/ui/add_admin.dart';
import 'package:mis_app/ui/add_course.dart';
import 'package:mis_app/ui/register_student.dart';

import 'package:mis_app/ui/view_adviser.dart';
import 'package:mis_app/ui/view_admin.dart';
import 'package:mis_app/ui/view_course_list.dart';
import 'package:mis_app/ui/view_student.dart';

import 'package:provider/provider.dart';
import 'package:mis_app/util/utility.dart';
import 'package:mis_app/widgets/ensure_visible.dart';

class AdminMenu extends StatefulWidget {
  const AdminMenu({Key? key}) : super(key: key);

  @override
  _AdminMenuState createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  final FocusNode _focusNodeAddAdviserBtn = FocusNode();
  final FocusNode _focusNodeAddAdminBtn = FocusNode();
  final FocusNode _focusNodeAddCourseBtn = FocusNode();
  final FocusNode _focusNodeAddStudentBtn = FocusNode();

  final FocusNode _focusNodeViewAdvisersBtn = FocusNode();
  final FocusNode _focusNodeViewAdminsBtn = FocusNode();
  final FocusNode _focusNodeViewCoursesBtn = FocusNode();
  final FocusNode _focusNodeViewStudentsBtn = FocusNode();

  _navigate(String buttonName) {
    if (buttonName == 'AddAdviserBtn') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddAdviser()));
    } else if (buttonName == 'AddAdminBtn') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddAdmin()));
    } else if (buttonName == 'AddCourseBtn') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddCourse()));
    } else if (buttonName == 'AddStudentBtn') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RegisterSudent()));
    } else if (buttonName == 'ViewAdvisersBtn') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ViewAdviser()));
    } else if (buttonName == 'ViewAdminsBtn') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ViewAdmin()));
    } else if (buttonName == 'ViewCoursesBtn') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ViewCourseList()));
    } else if (buttonName == 'ViewStudentsBtn') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ViewStudent()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => MaterialApp(
        theme: theme.getTheme(),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Admin Menu',
                style: TextStyle(
                  color: Colors.white,
                )),
            backgroundColor: Colors.redAccent[700],
          ),
          body: SafeArea(
            child: Container(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: InkWell(
                          focusNode: _focusNodeAddAdviserBtn,
                          onTap: () => _navigate('AddAdviserBtn'),
                          child: Center(
                            child: Text(
                              'Add Adviser',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: InkWell(
                          focusNode: _focusNodeAddAdminBtn,
                          onTap: () => _navigate('AddAdminBtn'),
                          child: Center(
                            child: Text(
                              'Add Admin',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: InkWell(
                          focusNode: _focusNodeAddCourseBtn,
                          onTap: () => _navigate('AddCourseBtn'),
                          child: Center(
                            child: Text(
                              'Add Course',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: InkWell(
                          focusNode: _focusNodeAddStudentBtn,
                          onTap: () => _navigate('AddStudentBtn'),
                          child: Center(
                            child: Text(
                              'Add Student',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: InkWell(
                          focusNode: _focusNodeViewAdvisersBtn,
                          onTap: () => _navigate('ViewAdvisersBtn'),
                          child: Center(
                            child: Text(
                              'View Advisers',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: InkWell(
                          focusNode: _focusNodeViewAdminsBtn,
                          onTap: () => _navigate('ViewAdminsBtn'),
                          child: Center(
                            child: Text(
                              'View Admins',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: InkWell(
                          focusNode: _focusNodeViewCoursesBtn,
                          onTap: () => _navigate('ViewCoursesBtn'),
                          child: Center(
                            child: Text(
                              'View Courses',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: InkWell(
                          focusNode: _focusNodeViewStudentsBtn,
                          onTap: () => _navigate('ViewStudentsBtn'),
                          child: Center(
                            child: Text(
                              'View Students',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
