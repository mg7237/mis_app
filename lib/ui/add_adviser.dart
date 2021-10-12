import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                        child: Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text('Add Adviser',
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Container(
                            height: 40,
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
                            height: 40,
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
                            height: 40,
                            child: TextFormField(
                              decoration:
                                  InputDecoration(hintText: 'Middle Initial'),
                              controller: middleNameController,
                              style: TextStyle(fontSize: 14),
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
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
                                            fontSize: 16, color: Colors.white),
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
                                        'Save',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                    onTap: () => {},
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ))))));
  }
}
