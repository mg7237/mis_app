import 'package:flutter/material.dart';
import 'package:mis_app/util/firebase_utilities.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/models/adviser_model.dart';
import 'package:mis_app/providers/theme_manager.dart';

class AddAdviser extends StatefulWidget {
  const AddAdviser({Key? key}) : super(key: key);

  @override
  _AddAdviserState createState() => _AddAdviserState();
}

class _AddAdviserState extends State<AddAdviser> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  static final addFormKey = GlobalKey<FormState>();

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
                        key: addFormKey,
                        child: Container(
                          margin: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Text('Add Adviser',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 20),
                              Container(
                                height: 70,
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(hintText: 'Last Name'),
                                  controller: lastNameController,
                                  style: TextStyle(fontSize: 14),
                                  keyboardType: TextInputType.name,
                                  validator: (String? value) {
                                    if (value == null || value == '') {
                                      return 'Please enter Last Name';
                                    }
                                  },
                                ),
                              ),
                              Container(
                                height: 70,
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(hintText: 'First Name'),
                                  controller: firstNameController,
                                  style: TextStyle(fontSize: 14),
                                  keyboardType: TextInputType.name,
                                  validator: (String? value) {
                                    if (value == null || value == '') {
                                      return 'Please enter First Name';
                                    }
                                  },
                                ),
                              ),
                              Container(
                                height: 70,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Middle Initial'),
                                  controller: middleNameController,
                                  style: TextStyle(fontSize: 14),
                                  keyboardType: TextInputType.name,
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
                                          firstNameController.text = '';
                                          lastNameController.text = '';
                                          middleNameController.text = '';
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
                                            if (addFormKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              Adviser adviser = Adviser(
                                                  firstName:
                                                      firstNameController.text,
                                                  lastName:
                                                      lastNameController.text,
                                                  middleName:
                                                      middleNameController
                                                          .text);
                                              var adv = await FirebaseUtilities
                                                  .addAdviser(adviser);
                                              if (adv != null) {
                                                await showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                          backgroundColor:
                                                              Colors.blue,
                                                          title: new Text(
                                                              'Success'),
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
                                                                    'Adviser Created Successfully'),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: <Widget>[
                                                            new IconButton(
                                                                icon: new Icon(
                                                                    Icons
                                                                        .close),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                })
                                                          ],
                                                        ));

                                                Navigator.pop(context);
                                              } else {
                                                await showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                          backgroundColor:
                                                              Colors.blue,
                                                          title: new Text(
                                                              'Failure'),
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
                                                                    'Adviser creation failed, please try again'),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: <Widget>[
                                                            new IconButton(
                                                                icon: new Icon(
                                                                    Icons
                                                                        .close),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                })
                                                          ],
                                                        ));
                                              }
                                            }
                                          })),
                                ],
                              ),
                            ],
                          ),
                        ))))));
  }
}
