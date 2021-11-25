import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';
import 'package:mis_app/util/firebase_utilities.dart';
import 'package:mis_app/models/student_model.dart';

class StudentHome extends StatefulWidget {
  final String email;
  const StudentHome({required this.email, Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  String _studentName = '';
  @override
  void initState() {
    super.initState();
    getUserName();
  }

  Future getUserName() async {
    Student? student =
        await FirebaseUtilities.getStudentDataByEmail(widget.email);
    if (student != null) {
      _studentName = student.lastName +
          ' ' +
          ' ' +
          student.middleName +
          ' ' +
          student.firstName +
          ' ';
      setState(() {});
    }
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
                    child: Center(
                      child: Text('Welcome ' + _studentName),
                    ),
                    color: Colors.grey[200],
                  )),
            )));
  }
}
