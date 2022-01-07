import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';
import 'package:mis_app/util/firebase_utilities.dart';
import 'package:mis_app/models/course_model.dart';
import 'package:mis_app/util/constants.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({Key? key}) : super(key: key);

  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  String defaultDropdownValue = 'Select';
  List<String> advisers = [];
  String? _selectedSemester;
  String? _selectedAdviser;
  String? _selectedAcademicLevel;
  String? _selectedFaculty;
  List<DropdownMenuItem<String>> facultyList = [];
  List<DropdownMenuItem<String>> advisersDropDown = [];
  TextEditingController shortCodeController = TextEditingController();
  TextEditingController courseNameController = TextEditingController();
  TextEditingController numberOfUnitsController = TextEditingController();
  static final addCourseKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    getAdviserList();
  }

  Future getAdviserList() async {
    advisers = await FirebaseUtilities.getAdviserList();
    advisersDropDown = [];
    if (advisers.length > 0) {
      advisers.forEach((adviserName) {
        advisersDropDown.add(DropdownMenuItem(
            child: Text(
              adviserName,
              style: TextStyle(fontSize: 14),
            ),
            value: adviserName));
      });
    }
    setState(() {});
  }

  void updateFacultyDropdown(String? selectedAcademicLevel) {
    facultyList = [];
    if (selectedAcademicLevel == null) return;
    List<String> faculties = academicData[selectedAcademicLevel]!.keys.toList();
    faculties.forEach((element) {
      facultyList.add(DropdownMenuItem(
          child: Text(element,
              overflow: TextOverflow.fade, style: TextStyle(fontSize: 14)),
          value: element));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, theme, _) => MaterialApp(
            theme: theme.getTheme(),
            home: SafeArea(
                child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: Form(
                        key: addCourseKey,
                        child: Container(
                          margin: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Text('Add Course',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 20),
                              Container(
                                height: 70,
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(hintText: 'Short Code'),
                                  controller: shortCodeController,
                                  style: TextStyle(fontSize: 14),
                                  keyboardType: TextInputType.name,
                                  validator: (String? value) {
                                    if (value == null || value == '') {
                                      return 'Please enter Short Code';
                                    }
                                  },
                                ),
                              ),
                              Container(
                                height: 70,
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(hintText: 'Course Name'),
                                  controller: courseNameController,
                                  style: TextStyle(fontSize: 14),
                                  keyboardType: TextInputType.name,
                                  validator: (String? value) {
                                    if (value == null || value == '') {
                                      return 'Please enter Course Name';
                                    }
                                  },
                                ),
                              ),
                              Container(
                                height: 70,
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(hintText: 'No. of Units'),
                                  controller: numberOfUnitsController,
                                  style: TextStyle(fontSize: 14),
                                  keyboardType: TextInputType.number,
                                  validator: (String? value) {
                                    if (value == null || value == '') {
                                      return 'Please enter No. of Units';
                                    }
                                  },
                                ),
                              ),
                              // academic level, Faculty,
                              Container(
                                padding: EdgeInsets.only(right: 10),
                                width: MediaQuery.of(context).size.width,
                                child: DropdownButtonFormField(
                                    isExpanded: true,
                                    value: _selectedAcademicLevel,
                                    validator: (value) {
                                      if (value == null || value == '') {
                                        return ('Please select academic level');
                                      }
                                    },
                                    onChanged: (String? value) {
                                      _selectedAcademicLevel = value;
                                      updateFacultyDropdown(
                                          _selectedAcademicLevel);
                                      _selectedFaculty = null;
                                      // _selectedCourse = null;
                                      setState(() {});
                                    },
                                    hint: Text('Select Academic Level',
                                        style: TextStyle(fontSize: 14)),
                                    items: [
                                      DropdownMenuItem(
                                        child: Text(
                                          academicData.keys.toList()[0],
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: academicData.keys.toList()[0],
                                      ),
                                      DropdownMenuItem(
                                          child: Text(
                                              academicData.keys.toList()[1],
                                              style: TextStyle(fontSize: 14)),
                                          value: academicData.keys.toList()[1]),
                                      DropdownMenuItem(
                                          child: Text(
                                              academicData.keys.toList()[2],
                                              style: TextStyle(fontSize: 14)),
                                          value: academicData.keys.toList()[2])
                                    ]),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 10),
                                width: MediaQuery.of(context).size.width,
                                child: DropdownButtonFormField<String>(
                                    hint: Text('Select Faculty',
                                        style: TextStyle(fontSize: 14)),
                                    isExpanded: true,
                                    value: _selectedFaculty,
                                    validator: (value) {
                                      if (value == null || value == '') {
                                        return ('Please select faculty');
                                      }
                                    },
                                    onChanged: (String? value) {
                                      _selectedFaculty = value ?? '';
                                      // updateCourseDropdown(_selectedFaculty);
                                      setState(() {});
                                    },
                                    items: facultyList),
                              ),

                              SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: DropdownButtonFormField<String>(
                                  hint: Text('Select Semester',
                                      style: TextStyle(fontSize: 14)),
                                  value: _selectedSemester,
                                  isExpanded: true,
                                  validator: (value) {
                                    if (value == null || value == '') {
                                      return ('Please select semester');
                                    }
                                  },
                                  onChanged: (String? value) {
                                    _selectedSemester = value ?? semesters[0];
                                    setState(() {});
                                  },
                                  items: [
                                    DropdownMenuItem(
                                        child: Text(
                                          semesters[0],
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: semesters[0]),
                                    DropdownMenuItem(
                                        child: Text(
                                          semesters[1],
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: semesters[1]),
                                    DropdownMenuItem(
                                        child: Text(
                                          semesters[2],
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: semesters[2]),
                                    DropdownMenuItem(
                                        child: Text(
                                          semesters[3],
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: semesters[3]),
                                    DropdownMenuItem(
                                        child: Text(
                                          semesters[4],
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: semesters[4]),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              advisersDropDown.length > 0
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: DropdownButtonFormField(
                                        hint: Text('Select Adviser',
                                            style: TextStyle(fontSize: 14)),
                                        value: _selectedAdviser,
                                        isExpanded: true,
                                        onChanged: (String? value) {
                                          _selectedAdviser = value ?? '';
                                          setState(() {});
                                        },
                                        validator: (value) {
                                          if (value == null || value == '') {
                                            return ('Please select adviser');
                                          }
                                        },
                                        items: advisersDropDown,
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(height: 50),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      height: 50,
                                      width: 160,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          border: Border.all(width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: InkWell(
                                        child: Center(
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                        onTap: () {
                                          shortCodeController.text = '';
                                          courseNameController.text = '';
                                          numberOfUnitsController.text = '';
                                          _selectedAdviser = advisers[0];
                                          _selectedSemester = semesters[0];
                                          setState(() {});
                                        },
                                      )),
                                  SizedBox(width: 20),
                                  Container(
                                      height: 50,
                                      width: 160,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          border: Border.all(width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: InkWell(
                                        child: Center(
                                          child: Text(
                                            'Save',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                        onTap: () async {
                                          if (addCourseKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            if (await FirebaseUtilities
                                                .createCourse(Course(
                                                    name: courseNameController
                                                        .text,
                                                    code: shortCodeController
                                                        .text,
                                                    unitsCount:
                                                        numberOfUnitsController
                                                            .text,
                                                    currentSemester:
                                                        _selectedSemester ?? '',
                                                    instructorName:
                                                        _selectedAdviser ?? '',
                                                    academicLevel:
                                                        _selectedAcademicLevel!,
                                                    faculty:
                                                        _selectedFaculty!))) {
                                              await showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      AlertDialog(
                                                        backgroundColor:
                                                            Colors.blue,
                                                        title:
                                                            new Text('Success'),
                                                        content: Container(
                                                          height: 100,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(''),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                  'Course Created Successfully'),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          new IconButton(
                                                              icon: new Icon(
                                                                  Icons.close),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        ],
                                                      ));

                                              Navigator.pop(
                                                context,
                                              );
                                            } else {
                                              await showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      AlertDialog(
                                                        backgroundColor:
                                                            Colors.blue,
                                                        title:
                                                            new Text('Failure'),
                                                        content: Container(
                                                          height: 100,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(''),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                  'Course creation failed, please try again'),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          new IconButton(
                                                              icon: new Icon(
                                                                  Icons.close),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        ],
                                                      ));
                                            }
                                          }
                                        },
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ))))));
  }
}
