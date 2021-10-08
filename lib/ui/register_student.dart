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
  Map<String, List<String>> classes = {
    'KAS 1': ['Name1 KAS 1', 'Name2 KAS 1', 'Name3 KAS 1'],
    'WIKA 1': ['Name1 WIKA 1', 'Name2 WIKA 1', 'Name3 WIKA 1'],
    'ETHICS 1': ['Name1 ETHICS 1', 'Name2 ETHICS 1', 'Name3 ETHICS 1'],
    'PE 1': ['Name1 PE 1', 'Name2 PE 1', 'Name3 PE 1'],
    'See all students': [],
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 70,
                                        width: 70,
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
                                                        'Select Image',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.grey),
                                                      ),
                                                      actions: <Widget>[
                                                        CupertinoActionSheetAction(
                                                          child: Text(
                                                              "Select from Camera"),
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
                                                              "Select from Gallery"),
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
                                    SizedBox(width: 20),
                                    Container(
                                      width: 200,
                                      height: 40,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            hintText: 'Student Number'),
                                        controller: studentNumberController,
                                        style: TextStyle(fontSize: 16),
                                        validator: (String? value) {
                                          if (value == null || value == '') {
                                            return 'Please enter Student Number';
                                          }
                                        },
                                      ),
                                    )
                                  ]),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text('Classes',
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  )),
            )));
  }
}
