import 'dart:io';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:mis_app/ui/admin_menu.dart';
import 'package:mis_app/util/preference_connector.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';
import 'package:mis_app/util/firebase_utilities.dart';
import 'package:mis_app/ui/student_home.dart';
import 'package:mis_app/models/student_model.dart';
import 'package:mis_app/models/adviser_model.dart';
import 'package:mis_app/util/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';

class RegisterSudent extends StatefulWidget {
  final bool newUser;
  final String email;
  const RegisterSudent({required this.newUser, required this.email, Key? key})
      : super(key: key);

  @override
  _RegisterSudentState createState() => _RegisterSudentState();
}

class _RegisterSudentState extends State<RegisterSudent> {
  String? _selectedAcademicLevel;
  String? _selectedFaculty;
  String? _selectedCourse;
  List<DropdownMenuItem<String>> facultyList = [];
  List<DropdownMenuItem<String>> courseList = [];
  List<String> advisers = [];
  String? _selectedAdviser;
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  TextEditingController studentNumberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  String _dateLabelText = 'Date of Birth';
  String _selectedSemester = 'Semester 1 2021-2022';
  String? url;

  static final registerKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> items = [];
  late double fieldWidth;
  @override
  void initState() {
    super.initState();
    _getAdvisers();
    if (!widget.newUser) populateStudentData();
  }

  Future populateStudentData() async {
    String userEmail = widget.email;
    Student? studentData =
        await FirebaseUtilities.getStudentDataByEmail(userEmail);
    if (studentData != null) {
      _selectedAcademicLevel = studentData.academicLevel;
      _selectedFaculty = studentData.faculty;
      _selectedCourse = studentData.program;
      _selectedAdviser = studentData.adviser;
      _selectedSemester = studentData.currentSemester;
      studentNumberController.text = studentData.rollNumber;
      firstNameController.text = studentData.firstName;
      lastNameController.text = studentData.lastName;
      middleNameController.text = studentData.middleName;
      dobController.text = studentData.dateOfBirth;
      url = studentData.photoUrl;
    }
  }

  _getAdvisers() async {
    List<Adviser> adviserData = await FirebaseUtilities.getAdvisers();
    adviserData.forEach((element) {
      advisers.add(FirebaseUtilities.fullName(
          firstName: element.firstName,
          lastName: element.lastName,
          middleName: element.middleName));
      ;
    });
    items = _getMenuItems();
    setState(() {});
  }

  List<DropdownMenuItem<String>> _getMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    advisers.forEach((element) {
      items.add(DropdownMenuItem(
          child: Text(element, style: TextStyle(fontSize: 14)),
          value: element));
    });
    return items;
  }

  Future getImage(bool result) async {
    if (result) {
      var _image = await _picker.pickImage(source: ImageSource.camera);
      if (_image != null) {
        setState(() {
          image = _image;
        });
      }
    } else {
      var _image = await _picker.pickImage(source: ImageSource.gallery);
      if (_image != null) {
        setState(() {
          image = _image;
        });
      }
    }
  }

  void updateFacultyDropdown(String? selectedAcademicLevel) {
    if (selectedAcademicLevel == null) return;
    facultyList = [];
    List<String> faculties = academicData[selectedAcademicLevel]!.keys.toList();
    faculties.forEach((element) {
      facultyList.add(DropdownMenuItem(
          child: Text(element,
              overflow: TextOverflow.fade, style: TextStyle(fontSize: 14)),
          value: element));
    });
  }

  void _registerStudent() async {
    String url = '';
    if (image != null) {
      url = await FirebaseUtilities.uploadImage(image!);
    }
    String id =
        await PreferenceConnector().getString(PreferenceConnector.USER_ID);
    Student student = Student(
        uid: id,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        middleName: middleNameController.text,
        academicLevel: _selectedAcademicLevel ?? '',
        program: _selectedCourse ?? '',
        faculty: _selectedFaculty ?? '',
        adviser: _selectedAdviser ?? '',
        photoUrl: url,
        rollNumber: studentNumberController.text,
        currentSemester: _selectedSemester,
        dateOfBirth: dobController.text);

    if (registerKey.currentState?.validate() ?? false) {
      if (await FirebaseUtilities.createStudent(student)) {
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  backgroundColor: Colors.blue,
                  title: Text('Success'),
                  content: Container(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(''),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Student Registered'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    new IconButton(
                        icon: new Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                ));
        String userType = await PreferenceConnector()
            .getString(PreferenceConnector.USER_TYPE);
        if (userType == 'STUDENT') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StudentHome(email: widget.email)));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AdminMenu()));
        }
      } else {
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  backgroundColor: Colors.blue,
                  title: Text('Failure'),
                  content: Container(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(''),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Register failed, please try again'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    new IconButton(
                        icon: new Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                ));
      }
    }
  }

  void updateCourseDropdown(String selectedFaculty) async {
    courseList = [];
    List<String> courses =
        await FirebaseUtilities.getCourseListByFaculty(selectedFaculty);
    if (courses.length == 0) return;

    courses.forEach((element) {
      courseList.add(DropdownMenuItem(
          child: Text(element,
              overflow: TextOverflow.fade, style: TextStyle(fontSize: 14)),
          value: element));
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    fieldWidth = MediaQuery.of(context).size.width - 80;
    return Consumer<ThemeNotifier>(
        builder: (context, theme, _) => MaterialApp(
            theme: theme.getTheme(),
            home: SafeArea(
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Form(
                    key: registerKey,
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 1),
                            Text('Sign Up',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold)),
                            SizedBox(height: 20),
                            Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    shape: BoxShape.circle),
                                child: InkWell(
                                    child: ClipOval(
                                      child: url != null
                                          ? Image(image: NetworkImage(url!))
                                          : image == null
                                              ? Image(
                                                  image: AssetImage(
                                                      'assets/icon/placeholder.jpg'))
                                              : Image.file(File(image!.path)),
                                    ),
                                    onTap: () async {
                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) {
                                            return CupertinoActionSheet(
                                              title: Text(
                                                ' Image',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.grey),
                                              ),
                                              actions: <Widget>[
                                                CupertinoActionSheetAction(
                                                  child: Text(" from Camera"),
                                                  onPressed: () async {
                                                    getImage(true);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                CupertinoActionSheetAction(
                                                  child: Text(" from Gallery"),
                                                  onPressed: () async {
                                                    getImage(false);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    })),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: fieldWidth,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  hintText: 'Student Number',
                                                  contentPadding:
                                                      new EdgeInsets.symmetric(
                                                          vertical: 0,
                                                          horizontal: 5.0),
                                                ),
                                                controller:
                                                    studentNumberController,
                                                style: TextStyle(fontSize: 14),
                                                keyboardType:
                                                    TextInputType.number,
                                                validator: (String? value) {
                                                  if (value == null ||
                                                      value == '') {
                                                    return 'Please enter Student Number';
                                                  }
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: fieldWidth,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                    hintText: 'Last Name',
                                                    contentPadding:
                                                        new EdgeInsets
                                                                .symmetric(
                                                            vertical: 0,
                                                            horizontal: 5.0)),
                                                controller: lastNameController,
                                                style: TextStyle(fontSize: 14),
                                                keyboardType:
                                                    TextInputType.name,
                                                validator: (String? value) {
                                                  if (value == null ||
                                                      value == '') {
                                                    return 'Please enter Last Name';
                                                  }
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: fieldWidth,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                    hintText: 'First Name',
                                                    contentPadding:
                                                        new EdgeInsets
                                                                .symmetric(
                                                            vertical: 0,
                                                            horizontal: 5.0)),
                                                controller: firstNameController,
                                                style: TextStyle(fontSize: 14),
                                                keyboardType:
                                                    TextInputType.name,
                                                validator: (String? value) {
                                                  if (value == null ||
                                                      value == '') {
                                                    return 'Please enter First Name';
                                                  }
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: fieldWidth,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                    hintText: 'Middle Initial',
                                                    contentPadding:
                                                        new EdgeInsets
                                                                .symmetric(
                                                            vertical: 0,
                                                            horizontal: 5.0)),
                                                controller:
                                                    middleNameController,
                                                style: TextStyle(fontSize: 14),
                                                keyboardType:
                                                    TextInputType.name,
                                              ),
                                            ),
                                            Container(
                                              width: fieldWidth,
                                              //padding: EdgeInsets.only(right: 10),
                                              child: DateTimePicker(
                                                calendarTitle:
                                                    'Select Date of Birth',
                                                type: DateTimePickerType.date,
                                                dateMask: 'dd MMM, yyyy',
                                                initialDate: DateTime(2000),
                                                controller: dobController,
                                                style: TextStyle(fontSize: 14),
                                                firstDate: DateTime(1950),
                                                lastDate: DateTime(2010),
                                                icon: Icon(Icons.event),
                                                dateLabelText: _dateLabelText,
                                                onChanged: (val) {
                                                  if (val != '') {
                                                    _dateLabelText = '';
                                                  } else {
                                                    _dateLabelText =
                                                        'Date of Birth';
                                                  }
                                                  setState(() {});
                                                },
                                                validator: (val) {
                                                  print(val);
                                                  return null;
                                                },
                                                onSaved: (val) => print(val),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: DropdownButton(
                                value: _selectedSemester,
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
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              width: MediaQuery.of(context).size.width,
                              child: DropdownButtonFormField(
                                  value: _selectedAcademicLevel,
                                  onChanged: (String? value) {
                                    _selectedAcademicLevel = value;
                                    updateFacultyDropdown(
                                        _selectedAcademicLevel);
                                    _selectedFaculty = null;
                                    _selectedCourse = null;
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
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              width: MediaQuery.of(context).size.width,
                              child: DropdownButtonFormField<String>(
                                  hint: Text('Select Faculty',
                                      style: TextStyle(fontSize: 14)),
                                  isExpanded: true,
                                  value: _selectedFaculty,
                                  onChanged: (String? value) {
                                    _selectedFaculty = value ?? '';
                                    updateCourseDropdown(
                                        _selectedFaculty ?? '');
                                  },
                                  items: facultyList),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              width: MediaQuery.of(context).size.width,
                              child: DropdownButtonFormField(
                                  hint: Text('Select Program',
                                      style: TextStyle(fontSize: 14)),
                                  isExpanded: true,
                                  value: _selectedCourse,
                                  onChanged: (String? value) {
                                    _selectedCourse = value ?? '';
                                    setState(() {});
                                  },
                                  items: courseList),
                            ),
                            SizedBox(height: 10),
                            // Container(
                            //   padding: EdgeInsets.only(right: 10),
                            //   width: MediaQuery.of(context).size.width,
                            //   child: DropdownButtonFormField<String>(
                            //       value: _selectedAdviser,
                            //       onChanged: (String? value) {
                            //         _selectedAdviser = value.toString();
                            //         setState(() {});
                            //       },
                            //       hint: Text('Select Adviser',
                            //           style: TextStyle(fontSize: 14)),
                            //       items: items),
                            // ),
                            SizedBox(height: 30),
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: Row(
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
                                        onTap: () {},
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
                                            'Register',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                        onTap: () => _registerStudent(),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            )));
  }
}
