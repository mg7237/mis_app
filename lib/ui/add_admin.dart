import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';

class AddAdmin extends StatefulWidget {
  const AddAdmin({Key? key}) : super(key: key);

  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                          Text('Add Admin',
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Container(
                            height: 40,
                            child: TextFormField(
                              decoration: InputDecoration(hintText: 'User Id'),
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
                            height: 40,
                            child: TextFormField(
                              decoration: InputDecoration(hintText: 'Password'),
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
