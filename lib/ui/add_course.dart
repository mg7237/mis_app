import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';
import 'package:mis_app/util/firebase_utilities.dart';
import 'package:mis_app/models/course_model.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({Key? key}) : super(key: key);

  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  TextEditingController shortCodeController = TextEditingController();
  TextEditingController courseNameController = TextEditingController();
  TextEditingController numberOfUnitsController = TextEditingController();
  static final addCourseKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
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
                              SizedBox(height: 30),
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
                                                            .text))) {
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
