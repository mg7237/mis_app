import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';

class RegisterSudent extends StatefulWidget {
  const RegisterSudent({Key? key}) : super(key: key);

  @override
  _RegisterSudentState createState() => _RegisterSudentState();
}

class _RegisterSudentState extends State<RegisterSudent> {
  String? _selectedAcademicLevel;
  String? _selectedFaculty;
  String? _selectedCourse;
  List<DropdownMenuItem<String>> facultyList = [];
  List<DropdownMenuItem<String>> courseList = [];

  Map<String, Map<String, List<String>>> academicData = {
    'Under Graduate': {
      'Faculty of Education': [
        'Associate in arts',
        'Bachelor of Education Studies'
      ],
      'Faculty of Information & Communication Studies': [
        'Bachelor of Arts in Multimedia Studies'
      ]
    },
    'Graduate': {
      'Faculty of Education': [
        'Graduate Certificate Faculty of Education Graduate Certificate in Distance Education'
      ],
      'Faculty of Management & Development Studies': [
        'Graduate Certificate in ASEAN Studies'
      ]
    },
    'Diploma': {
      'Faculty of Education': [
        'Diploma in Science Teaching',
        'Diploma in Mathematics Teaching',
        'Diploma in Language and Literacy Education',
        'Diploma in Social Studies Education'
      ],
      'Faculty of Management & Development Studies': [
        'Diploma in Environment and Natural Resource Management',
        'Diploma in International Health',
        'Diploma in Land Valuation and Management',
        'Diploma in Research and Development Management',
        'Diploma in Land Use Planning',
        'Diploma in Social Work',
        'Diploma in Women and Development'
      ],
      'Faculty of Information & Communication Studies': [
        'Diploma in Computer Science'
      ],
    },
  };

  XFile? image;
  TextEditingController studentNumberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController academicLevel = TextEditingController();
  TextEditingController facultyController = TextEditingController();
  TextEditingController programController = TextEditingController();
  TextEditingController advisorController = TextEditingController();

  checkPermission(bool result) async {
    if (result) {
      getImage(result);
    } else {
      getImage(false);
    }
  }

  void updateFacultyDropdown(String? selectedAcademicLevel) {
    if (selectedAcademicLevel == null) return;
    List<String> faculties = academicData[selectedAcademicLevel]!.keys.toList();
    faculties.forEach((element) {
      facultyList.add(DropdownMenuItem(
          child: Text(element,
              overflow: TextOverflow.fade, style: TextStyle(fontSize: 14)),
          value: element));
    });
  }

  void updateCourseDropdown(String? selectedFaculty) {
    if (selectedFaculty == null) return;
    List<String>? courses =
        academicData[_selectedAcademicLevel]![selectedFaculty];
    courses?.forEach((element) {
      courseList.add(DropdownMenuItem(
          child: Text(element,
              overflow: TextOverflow.fade, style: TextStyle(fontSize: 14)),
          value: element));
    });
  }

  Future getImage(bool result) async {
    if (result) {
      var _image =
          await ImagePicker.platform.getImage(source: ImageSource.camera);
      if (_image != null) {
        setState(() {
          image = _image;
        });
      }
    } else {
      var _image =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);
      if (_image != null) {
        setState(() {
          image = _image;
        });
      }
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
                  body: Form(
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text('Sign Up',
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Column(
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 100,
                                        width: 100,
                                        child: InkWell(
                                            child: Image(
                                                image: AssetImage(
                                                    'assets/icon/placeholder.jpg')),
                                            onTap: () async {
                                              bool checkCameraPermission =
                                                  false;
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
                                                          child: Text(
                                                              " from Camera"),
                                                          onPressed: () async {
                                                            checkCameraPermission =
                                                                true;
                                                            checkPermission(
                                                                checkCameraPermission);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        CupertinoActionSheetAction(
                                                          child: Text(
                                                              " from Gallery"),
                                                          onPressed: () async {
                                                            checkPermission(
                                                                false);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            })),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 220,
                                            height: 30,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  hintText: 'Student Number'),
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
                                            width: 220,
                                            height: 40,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  hintText: 'Last Name'),
                                              controller: lastNameController,
                                              style: TextStyle(fontSize: 14),
                                              keyboardType: TextInputType.name,
                                              validator: (String? value) {
                                                if (value == null ||
                                                    value == '') {
                                                  return 'Please enter Last Name';
                                                }
                                              },
                                            ),
                                          ),
                                          Container(
                                            width: 220,
                                            height: 40,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  hintText: 'First Name'),
                                              controller: firstNameController,
                                              style: TextStyle(fontSize: 14),
                                              keyboardType: TextInputType.name,
                                              validator: (String? value) {
                                                if (value == null ||
                                                    value == '') {
                                                  return 'Please enter First Name';
                                                }
                                              },
                                            ),
                                          ),
                                          Container(
                                            width: 220,
                                            height: 40,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  hintText: 'Middle Initial'),
                                              controller: middleNameController,
                                              style: TextStyle(fontSize: 14),
                                              keyboardType: TextInputType.name,
                                            ),
                                          )
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
                            padding: EdgeInsets.only(right: 10),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonFormField(
                                value: _selectedAcademicLevel,
                                onChanged: (String? value) {
                                  _selectedAcademicLevel = value;
                                  updateFacultyDropdown(_selectedAcademicLevel);
                                  _selectedFaculty = null;
                                  _selectedCourse = null;
                                  setState(() {});
                                },
                                hint: Text('Select Academic Level'),
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      academicData.keys.toList()[0],
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    value: academicData.keys.toList()[0],
                                  ),
                                  DropdownMenuItem(
                                      child: Text(academicData.keys.toList()[1],
                                          style: TextStyle(fontSize: 14)),
                                      value: academicData.keys.toList()[1]),
                                  DropdownMenuItem(
                                      child: Text(academicData.keys.toList()[2],
                                          style: TextStyle(fontSize: 14)),
                                      value: academicData.keys.toList()[2])
                                ]),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonFormField<String>(
                                hint: Text('Select Faculty'),
                                isExpanded: true,
                                value: _selectedFaculty,
                                onChanged: (String? value) {
                                  _selectedFaculty = value ?? '';
                                  updateCourseDropdown(_selectedFaculty);
                                  setState(() {});
                                },
                                items: facultyList),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonFormField(
                                hint: Text('Select Program'),
                                isExpanded: true,
                                value: _selectedCourse,
                                onChanged: (String? value) {
                                  _selectedCourse = value ?? '';
                                  setState(() {});
                                },
                                items: courseList),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 30,
                            padding: EdgeInsets.only(right: 10),
                            child: TextFormField(
                              decoration: InputDecoration(hintText: 'Adviser'),
                              controller: studentNumberController,
                              style: TextStyle(fontSize: 14),
                              keyboardType: TextInputType.number,
                              validator: (String? value) {
                                if (value == null || value == '') {
                                  return 'Please enter Adviser';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            )));
  }
}
