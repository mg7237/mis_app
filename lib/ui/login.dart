import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mis_app/ui/admin_menu.dart';
import 'package:mis_app/ui/view_advisor.dart';
import 'package:mis_app/ui/view_course.dart';
import 'package:mis_app/ui/view_course_list.dart';
import 'package:mis_app/ui/view_student.dart';
import 'package:mis_app/ui/register_student.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';
import 'package:mis_app/util/utility.dart';
import 'package:mis_app/widgets/ensure_visible.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FocusNode _focusNodeUserId = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeLoginBtn = FocusNode();

  static final TextEditingController _userIdController =
      TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();

  bool passwordVisible = false;
  bool rememberMe = false;
  _cancel() {
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => ViewAdvisor()));
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => ViewCourse()));
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => ViewStudent()));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ViewCourseList()));
  }

  _showHidePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  _login() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AdminMenu()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<ThemeNotifier>(
        builder: (context, theme, _) => MaterialApp(
            theme: theme.getTheme(),
            home: SafeArea(
                child: Material(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: MediaQuery.of(context).size.width - 100,
                      child: Center(
                          child: Image(
                              image: AssetImage('assets/icon/app_logo.png')))),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            autofocus: true,
                            //enabled: !showLoader,
                            style: TextStyle(fontSize: 18),
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(style: BorderStyle.none),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                hintText: 'User Id',
                                hintStyle: TextStyle(color: Colors.black),
                                fillColor: Colors.white),
                            // onSaved: (value) =>
                            //     _loginRequestModel.email = value,
                            //validator: _loginRequestModel.emailValidate,
                            validator: (value) {
                              if ((value ?? '') != '') {
                                return null;
                              } else
                                return 'Enter User Id';
                            },
                            controller: _userIdController,
                            focusNode: _focusNodeUserId,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (value) {
                              fieldFocusChange(context, _focusNodeUserId,
                                  _focusNodePassword);
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Stack(children: [
                              TextFormField(
                                style: TextStyle(fontSize: 18),
                                //enabled: !showLoader,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.black),
                                ),

                                // onSaved: (value) =>
                                //     _loginRequestModel.email = value,
                                //validator: _loginRequestModel.emailValidate,
                                validator: (value) {
                                  if ((value ?? '') != '') {
                                    return null;
                                  } else
                                    return 'Enter Password';
                                },
                                controller: _passwordController,
                                focusNode: _focusNodePassword,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !passwordVisible,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (value) {
                                  fieldFocusChange(context, _focusNodePassword,
                                      _focusNodeLoginBtn);
                                },
                              ),
                              Positioned(
                                right: 20,
                                top: 10,
                                child: InkWell(
                                  onTap: () {
                                    _showHidePassword();
                                  },
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      child: Image(
                                        image: passwordVisible
                                            ? AssetImage(
                                                'assets/icon/close_visibility.png')
                                            : AssetImage(
                                                'assets/icon/open_visibility.png'),
                                      )),
                                ),
                              )
                            ])),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Checkbox(
                                  value: rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      rememberMe = value ?? false;
                                    });
                                  }),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Remember Me?',
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          ),
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
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                    onTap: () => _cancel(),
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
                                    focusNode: _focusNodeLoginBtn,
                                    child: Center(
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                    onTap: () => _login(),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterSudent()));
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue[800],
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            'Forgot Username & Password',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue[800],
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
            ))),
      ),
    );
  }
}
