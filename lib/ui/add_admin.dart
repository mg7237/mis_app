import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';
import 'package:mis_app/util/firebase_utilities.dart';

class AddAdmin extends StatefulWidget {
  const AddAdmin({Key? key}) : super(key: key);

  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  static final addAdminKey = GlobalKey<FormState>();

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
                        key: addAdminKey,
                        child: Container(
                          margin: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Text('Add Admin',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 20),
                              Container(
                                height: 70,
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(hintText: 'User Id'),
                                  controller: userIdController,
                                  style: TextStyle(fontSize: 14),
                                  keyboardType: TextInputType.name,
                                  validator: (String? value) {
                                    if (value == null || value == '') {
                                      return 'Please enter User Id';
                                    }
                                  },
                                ),
                              ),
                              Container(
                                height: 70,
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(hintText: 'Password'),
                                  controller: passwordController,
                                  style: TextStyle(fontSize: 14),
                                  keyboardType: TextInputType.name,
                                  validator: (String? value) {
                                    if (value == null || value == '') {
                                      return 'Please enter Password';
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
                                          userIdController.text = '';
                                          passwordController.text = '';
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
                                          if (addAdminKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            if (passwordController.text
                                                        .trim() ==
                                                    '' ||
                                                userIdController.text.trim() ==
                                                    '') {
                                              return;
                                            }

                                            if (await FirebaseUtilities
                                                .createAdminWithEmailAndPassword(
                                                    email: userIdController.text
                                                        .trim(),
                                                    password: passwordController
                                                        .text
                                                        .trim())) {
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
                                                                  'Admin Created Successfully'),
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

                                              Navigator.pop(context);
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
                                                                  'Admin creation failed, please try again'),
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
