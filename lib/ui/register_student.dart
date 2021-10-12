import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
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
  List<String> advisers = ['John Doe', 'Jack Doe', 'Jane Doe'];
  String? _selectedAdviser;

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
  TextEditingController dobController = TextEditingController();
  String _dateLabelText = 'Date of Birth';

  @override
  void initState() {
    super.initState();
  }

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
                                          ),
                                          Container(
                                            height: 40,
                                            width: 220,
                                            padding: EdgeInsets.only(right: 10),
                                            child: DateTimePicker(
                                              calendarTitle:
                                                  'Select Date of Birth',
                                              type: DateTimePickerType.date,
                                              dateMask: 'dd MMM, yyyy',
                                              initialDate: DateTime(2000),
                                              initialValue: '',
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
                                hint: Text('Select Faculty',
                                    style: TextStyle(fontSize: 14)),
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
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonFormField(
                                value: _selectedAdviser,
                                onChanged: (String? value) {
                                  _selectedAdviser = value;
                                  setState(() {});
                                },
                                hint: Text('Select Adviser',
                                    style: TextStyle(fontSize: 14)),
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      advisers[0],
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    value: academicData.keys.toList()[0],
                                  ),
                                  DropdownMenuItem(
                                      child: Text(advisers[1],
                                          style: TextStyle(fontSize: 14)),
                                      value: advisers[1]),
                                  DropdownMenuItem(
                                      child: Text(advisers[2],
                                          style: TextStyle(fontSize: 14)),
                                      value: advisers[2])
                                ]),
                          ),
                          SizedBox(height: 30),
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      onTap: () => {},
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            )));
  }
}
